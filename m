Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVD0JZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVD0JZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 05:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVD0JZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 05:25:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54404 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261269AbVD0JZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 05:25:14 -0400
Date: Wed, 27 Apr 2005 11:24:50 +0200
From: Pavel Machek <pavel@suse.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050427092450.GB1819@elf.ucw.cz>
References: <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Could we get root-only fuse in, please?
> > > 
> > > chmod u-s /usr/bin/fusermount
> > 
> > :-)))). I meant merging patches that are not controversial into
> > mainline. AFAICT only controversial pieces are "make it safe for
> > non-root users"...
> 
> This is the controversial part in all it's glory:
> 
> 	if (!(fc->flags & FUSE_ALLOW_OTHER) && current->fsuid != fc->user_id)
> 		return -EACCES;
> 
> Leaving it out would gain us what exactly?

Well, if it brings us ugly semantics, keeping those two lines out for
a while can help merge a lot...
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
