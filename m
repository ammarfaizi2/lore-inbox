Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbTAPNJP>; Thu, 16 Jan 2003 08:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbTAPNJP>; Thu, 16 Jan 2003 08:09:15 -0500
Received: from mons.uio.no ([129.240.130.14]:2235 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267059AbTAPNJP>;
	Thu, 16 Jan 2003 08:09:15 -0500
To: Tim Connors <tconnors@astro.swin.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [NFS] Re: broken umount -f
References: <20030114160031$24bb@gated-at.bofh.it>
	<200301160955.h0G9ttZ27704@hexane.ssi.swin.edu.au>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 16 Jan 2003 14:17:50 +0100
In-Reply-To: <200301160955.h0G9ttZ27704@hexane.ssi.swin.edu.au>
Message-ID: <shsd6mxp729.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Tim Connors <tconnors@astro.swin.edu.au> writes:

     > What I have never understood, is that if you are reading a
     > file, or even just in a directory, and the server goes down,
     > and won't come back up (say, you have taken your laptop into
     > work, and forgot to turn off autofs first, after killing all
     > shells that had cd'd to the nfs directory), then you still are
     > destined to have to reboot. You could sever all connections to
     > the nfs server safely, because nothing is being written there
     > (except maybe atime information - but not in the case of a
     > shell being cd'd to an nfs path). But linux won't give up on
     > the connection. Come on, what harm could possibly come to an
     > application that has only readonly files open, or cwd in an NFS
     > path?  No data loss would occur in this situation, so just drop
     > the connection, and return -EIO to anything that then later
     > wants to read a file.

Care to contribute the code?

Cheers,
  Trond
