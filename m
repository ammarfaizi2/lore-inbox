Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSHOXEX>; Thu, 15 Aug 2002 19:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSHOXEX>; Thu, 15 Aug 2002 19:04:23 -0400
Received: from mons.uio.no ([129.240.130.14]:22698 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317641AbSHOXEX>;
	Thu, 15 Aug 2002 19:04:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15708.13368.625078.207115@charged.uio.no>
Date: Fri, 16 Aug 2002 01:07:36 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dax Kelson <dax@gurulabs.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Kendrick M. Smith" <kmsmith@umich.edu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "nfs@lists.sourceforge.net" <nfs@lists.sourceforge.net>,
       <beepy@netapp.com>
Subject: Re: Will NFSv4 be accepted?
In-Reply-To: <Pine.LNX.4.44.0208151027510.3130-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208141938350.31203-100000@mooru.gurulabs.com>
	<Pine.LNX.4.44.0208151027510.3130-100000@home.transmeta.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > I personally doubt that NFS would be the thing driving
     > this. Judging by past performance, NFS security issues don't
     > seem to bother people. I'd personally assume that the thing
     > that would be important enough to people for vendors to add it
     > is VPN or encrypted (local) disks.

As I said: one of the main motivations for NFSv4 is WAN support, and
in those environments, strong authentication is a must.

That said, the plan is to also prepare a 'null' authentication scheme
for RPCSEC_GSS (basically using RPCSEC_GSS as a wrapper for AUTH_UNIX)
so that the strong auth can be provided as a simple plugin in case its
inclusion in the kernel would not be acceptable.

Cheers,
  Trond
