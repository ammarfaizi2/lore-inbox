Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSEUL5Z>; Tue, 21 May 2002 07:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSEUL5Y>; Tue, 21 May 2002 07:57:24 -0400
Received: from khazad-dum.debian.net ([200.196.10.6]:8326 "EHLO
	khazad-dum.debian.net") by vger.kernel.org with ESMTP
	id <S313477AbSEUL5Y>; Tue, 21 May 2002 07:57:24 -0400
Date: Tue, 21 May 2002 08:57:23 -0300
To: linux-kernel@vger.kernel.org
Cc: Antti Salmela <asalmela@iki.fi>
Subject: Re: ext3 assertion failure and oops, 2.4.18
Message-ID: <20020521085723.A32143@khazad-dum>
In-Reply-To: <20020521114244.GA29043@otitsun.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-GPG-Fingerprint-1: 1024D/128D36EE 50AC 661A 7963 0BBA 8155  43D5 6EF7 F36B 128D 36EE
X-GPG-Fingerprint-2: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
From: hmh@rcm.org.br (Henrique de Moraes Holschuh)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002, Antti Salmela wrote:
> I can reliably reproduce an assertion failure and oops in ext3 by simply
> restarting cyrus21, if directories used by cyrus have +j flag set with
> chattr. Filesystem was mounted with default journalling mode data=orderded,
> kernels tested were 2.4.18 and 2.4.19-pre3-ac4. Recent -pre or -ac kernels
> wouldn't compile with my .config.

I can atest to this, too. 2.4.18 stock, if I use the +j flag, the kernel
will oops with the exact same assertion failure.  The access pattern is that
of Sleepycat DB3 doing a database snapshot in a subdirectory of the
directory with the +j attribute set.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
