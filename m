Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129323AbRBOJyb>; Thu, 15 Feb 2001 04:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRBOJyL>; Thu, 15 Feb 2001 04:54:11 -0500
Received: from pat.uio.no ([129.240.130.16]:57548 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129323AbRBOJyE>;
	Thu, 15 Feb 2001 04:54:04 -0500
To: "List User" <lists@chaven.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: NFS mounting delays w/ 2.4.x kernel?
In-Reply-To: <20010215002012.A21227@gamersgold.net>
	<031001c096e9$2c437a60$160912ac@stcostlnds2zxj>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 15 Feb 2001 10:53:53 +0100
In-Reply-To: "List User"'s message of "Wed, 14 Feb 2001 18:49:29 -0600"
Message-ID: <shshf1we0ge.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == List User <lists@chaven.com> writes:

     > I've seen reference to this before (I think on this list) but
     > didn't pay attention to them at the time.  I am now running
     > into this problem myself.  I've just upgraded one of my NFS
     > servers here from 2.2.17 -> 2.4.1 ).

     > I'm running the user-space server nfs-server-2.2beta48 (tried
     > beta47 as well).  Current versions of mount, et al.  When
     > booting I get the following errors:

     > --------------------------- Mounted devfs on /dev Trying to
     > unmount old root ... okay Freeing unused kernel memory: 228k
     > freed Adding Swap: 1048568k swap-space (priority -1) portmap:
     > server localhost not responding, timed out portmap: server
     > localhost not responding, timed out lockd_up: makesock failed,
     > error=-5 portmap: server localhost not responding, timed out
     > -----------------------------

You need to add 'nolock' to your mount options. Unfsd doesn't support
NLM locking, and it's causing the lockd daemon to be started (which
again requires the portmapper to be installed etc.).

Cheers,
  Trond
