Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbREUVdj>; Mon, 21 May 2001 17:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262496AbREUVd3>; Mon, 21 May 2001 17:33:29 -0400
Received: from jalon.able.es ([212.97.163.2]:21697 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262492AbREUVdL>;
	Mon, 21 May 2001 17:33:11 -0400
Date: Mon, 21 May 2001 23:33:03 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac12
Message-ID: <20010521233303.A7310@werewolf.able.es>
In-Reply-To: <20010521201418.A2863@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010521201418.A2863@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Mon, May 21, 2001 at 21:14:18 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.21 Alan Cox wrote:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> 		 Intermediate diffs are available from
> 			http://www.bzimage.org
> 
> 
> 2.4.4-ac12
> o	Just tracking Linus 2.4.5pre4			
> 	- A chunk more merged with Linus
> 	- dropped out some oddments that are now
> 	  obsolete
> 

Two buglets:
- missing version bump from ac11 to ac12...
- missing change in binfmt_misc.c from lookup_one to lookup_one_len
	(is this the correct fix ? len is not already on Node...)

--- linux-2.4.4-ac12/fs/binfmt_misc.c.orig	Mon May 21 23:22:29 2001
+++ linux-2.4.4-ac12/fs/binfmt_misc.c	Mon May 21 23:24:53 2001
@@ -501,7 +501,7 @@
 
 	root = dget(sb->s_root);
 	down(&root->d_inode->i_sem);
-	dentry = lookup_one(e->name, root);
+	dentry = lookup_one_len(e->name, root, strlen(e->name));
 	err = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		down(&root->d_inode->i_zombie);

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.4-ac11 #2 SMP Fri May 18 12:27:06 CEST 2001 i686

