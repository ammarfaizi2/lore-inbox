Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbTCGPmX>; Fri, 7 Mar 2003 10:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261648AbTCGPmX>; Fri, 7 Mar 2003 10:42:23 -0500
Received: from mons.uio.no ([129.240.130.14]:62891 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S261639AbTCGPmU>;
	Fri, 7 Mar 2003 10:42:20 -0500
To: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client with sync mount option to sloooow
References: <m3d6l3s1hb.fsf@Janik.cz>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 07 Mar 2003 16:52:46 +0100
In-Reply-To: <m3d6l3s1hb.fsf@Janik.cz>
Message-ID: <shsof4nnpgx.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Pavel Jan <Pavel@Janik.cz> writes:

    > 2.4.20:~ mount -o tcp,sync PowerVault:/Share /mnt 2.4.20:~ time
     > dd if=/tmp/kcore of=/mnt

     > This took unbelievable amount of 21minutes! Reverse direction
     > is OK!

     > I tried to "upgrade" the kernel on 600SC from 2.4.10-SuSE

Wake up and read the spec. When you do sync writes, NFS has to commit
writes to disk on the server *BEFORE* it is allowed to reply to the
client. Adding GigE won't help the server one bit when the bottleneck
lies in the fact that it has to spin up the disk for every request.

Cheers,
  Trond
