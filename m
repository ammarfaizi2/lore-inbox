Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVD0SM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVD0SM2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVD0SKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:10:14 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:39845 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261927AbVD0SJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:09:47 -0400
To: linuxram@us.ibm.com
CC: lmb@suse.de, mj@ucw.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1114624541.4480.187.camel@localhost> (message from Ram on Wed,
	27 Apr 2005 10:55:41 -0700)
Subject: Re: [PATCH] private mounts
References: <20050426094727.GA30379@infradead.org>
	 <20050426131943.GC2226@openzaurus.ucw.cz>
	 <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu>
	 <20050426201411.GA20109@elf.ucw.cz>
	 <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu>
	 <20050427092450.GB1819@elf.ucw.cz>
	 <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu>
	 <20050427143126.GB1957@mail.shareable.org>
	 <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu>
	 <20050427153320.GA19065@atrey.karlin.mff.cuni.cz>
	 <20050427155022.GR4431@marowsky-bree.de>
	 <E1DQqQ0-0002PB-00@dorka.pomaz.szeredi.hu>
	 <1114623598.4480.181.camel@localhost>
	 <E1DQqdW-0002SN-00@dorka.pomaz.szeredi.hu> <1114624541.4480.187.camel@localhost>
Message-Id: <E1DQqyY-0002WW-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 20:09:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> eg:
>  
> user 1 does a invisible mount on /mnt/mnt1
> root does a visible mount on /mnt/mnt1
> 
> user 1 will no longer be able to access his /mnt/mnt1
> 
> in fact even if root mounts something on /mnt, the problem still exists.

This is not something specific to FUSE.  Root can overmount any of
your directories after which you won't be able to access it (unless
some of your processes have a CWD there).

Miklos
