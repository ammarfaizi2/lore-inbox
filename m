Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbTBXQkj>; Mon, 24 Feb 2003 11:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbTBXQkj>; Mon, 24 Feb 2003 11:40:39 -0500
Received: from mons.uio.no ([129.240.130.14]:1512 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267265AbTBXQkh>;
	Mon, 24 Feb 2003 11:40:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15962.19783.182617.822504@charged.uio.no>
Date: Mon, 24 Feb 2003 17:50:15 +0100
To: Oleg Drokin <green@namesys.com>
Cc: Andrew Morton <akpm@digeo.com>, vs@namesys.com, nikita@namesys.com,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4 iget5_locked port attempt to 2.4 (supposedly fixed NFS version this time)
In-Reply-To: <20030224132145.A7399@namesys.com>
References: <20030220175309.A23616@namesys.com>
	<20030220154924.7171cbd7.akpm@digeo.com>
	<20030221220341.A9325@namesys.com>
	<20030221200440.GA23699@delft.aura.cs.cmu.edu>
	<20030224132145.A7399@namesys.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Oleg Drokin <green@namesys.com> writes:

     >     Original patch was from Jan Harkes <jaharkes@cs.cmu.edu>,
     >     and was applied somewhere at the beginning of 2.5
     >     development.  It still would be nice if someone more
     >     knowledgeable in NFS client code will review the changes
     >     (and the same is true for Coda of course).

Please remind me. Why can't NFS set inode->i_mode, call
nfs_fill_inode() etc. in the 'init_locked' callback?

As for the issue of the stat() problem you mentioned: does your server
have a monotonically increasing inode->i_ctime? If ntp or something
like that keeps turning the clock backward on the server, then the NFS
client has no chance of recognizing which attribute updates are the
more recent ones.

Cheers,
  Trond
