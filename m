Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752473AbWCGCCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbWCGCCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 21:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbWCGCCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:02:15 -0500
Received: from ns.suse.de ([195.135.220.2]:45195 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752473AbWCGCCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:02:14 -0500
From: Neil Brown <neilb@suse.de>
To: Kirill Korotaev <dev@openvz.org>
Date: Tue, 7 Mar 2006 13:01:13 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17420.59753.598191.388029@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olh@suse.de>, Jan Blunck <jblunck@suse.de>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
In-Reply-To: message from Kirill Korotaev on Monday March 6
References: <17414.38749.886125.282255@cse.unsw.edu.au>
	<17419.53761.295044.78549@cse.unsw.edu.au>
	<440C236A.90700@openvz.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 6, dev@openvz.org wrote:
> 
> In general your patch is still does what mine do, so I will be happy if 
> any of this is commited mainstream. In future, please, keep the 
> reference to original authors, this will also make sure that I'm on CC 
> if something goes wrong.

Sorry: which 'original author' did I miss ?

> >  
> > +		if (dentry->d_sb->s_root == NULL &&
> > +		    (parent == NULL ||
> > +		     parent->d_sb != dentry->d_sb))
> > +			continue;
> <<<<
> - we select some dentries in select_parent and then try to prune N 
> dentries. But this can be other N dentries :/ It's not the problem with 
> your code, but... adding 'parent' arg to prune_dcache() makes me feel 
> the same as with 'found' arg: you don't use it actually right way. You 
> don't prune only its children, you see? It is better to pass 'sb' arg then.
> 

That's a valid point.  I should be passing 'sb'.

Thanks,
NeilBrown
