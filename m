Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317632AbSGVPjo>; Mon, 22 Jul 2002 11:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317634AbSGVPjo>; Mon, 22 Jul 2002 11:39:44 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:31226 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317632AbSGVPjn>; Mon, 22 Jul 2002 11:39:43 -0400
Subject: Re: [PATCH] 2.5.27 read_write
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D3C11DE.7010000@evision.ag>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com> 
	<3D3C11DE.7010000@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 17:55:23 +0100
Message-Id: <1027356923.31787.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 15:08, Marcin Dalecki wrote:
> - It is fixing completely confused wild casting to 32 bits.
> 
> - Actually adding a comment explaining the obscure code, which is
>    relying on integer arithmetics overflow.

Better yet take the code from 2.4.19-rc3. The code you fixed up is still
wrong. Sincie iov_len is not permitted to exceed 2Gb (SuS v3, found by
the LSB test suite) the actual fix turns out to be even simpler and
cleaner than the one you did


