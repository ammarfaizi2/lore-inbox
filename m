Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270634AbRH1KSS>; Tue, 28 Aug 2001 06:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270640AbRH1KSI>; Tue, 28 Aug 2001 06:18:08 -0400
Received: from mons.uio.no ([129.240.130.14]:61321 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S270634AbRH1KRx>;
	Tue, 28 Aug 2001 06:17:53 -0400
To: volodya@mindspring.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS in 2.4.9
In-Reply-To: <Pine.LNX.4.20.0108271739400.15526-100000@node2.localnet.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 28 Aug 2001 12:18:06 +0200
In-Reply-To: volodya@mindspring.com's message of "Mon, 27 Aug 2001 17:50:21 -0400 (EDT)"
Message-ID: <shsbsl0ij35.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == volodya  <volodya@mindspring.com> writes:

     > I have upgraded to 2.4.9 and NFS no longer works for me. I get
     > ---------------------------------------------------------------
     > NFS: NFSv3 not supported.  nfs warning: mount version older
     > than kernel

You forgot to enable NFSv3 support in your 2.4.9 kernel.

     > ---------------------------------------------------------------
     > even though I upgraded to the most recent version of util-linux
     > (2.11h) and when reading certain files programs lock up and the
     > kernel prints out the following messages:

     > nfs: server node4 not responding, still trying nfs: server
     > node4 not responding, still trying

     > However, node4 is fine (I can telnet in it) and seems to work
     > ok. (node4 is running 2.4.7, with knfsd).

In 99.999% of cases this is due to a network configuration
error. Usually it's things like running full-duplex against a
half-duplex capable switch etc.
TCP is less sensitive to this sort of thing than UDP is, so you won't
see it using telnet.

If you can't resolve where the problem lies, try setting rsize and
wsize manually to some smaller value.

Cheers,
  Trond
