Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbTBXQwr>; Mon, 24 Feb 2003 11:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbTBXQwr>; Mon, 24 Feb 2003 11:52:47 -0500
Received: from mons.uio.no ([129.240.130.14]:51176 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267091AbTBXQwr>;
	Mon, 24 Feb 2003 11:52:47 -0500
To: Oleg Drokin <green@namesys.com>
Cc: Andrew Morton <akpm@digeo.com>, vs@namesys.com, nikita@namesys.com,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4 iget5_locked port attempt to 2.4 (supposedly fixed NFS version this time)
References: <20030220175309.A23616@namesys.com>
	<20030220154924.7171cbd7.akpm@digeo.com>
	<20030221220341.A9325@namesys.com>
	<20030221200440.GA23699@delft.aura.cs.cmu.edu>
	<20030224132145.A7399@namesys.com>
	<15962.19783.182617.822504@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 24 Feb 2003 18:02:50 +0100
In-Reply-To: <15962.19783.182617.822504@charged.uio.no>
Message-ID: <shsbs11y5l1.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

>>>>> " " == Oleg Drokin <green@namesys.com> writes:

     > Please remind me. Why can't NFS set inode->i_mode, call
     > nfs_fill_inode() etc. in the 'init_locked' callback?

Duh, forget that question. The latter is called with the global inode
lock held which you want to release asap.

Cheers,
  Trond
