Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVEFKec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVEFKec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 06:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVEFKeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 06:34:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26838 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261204AbVEFKe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 06:34:29 -0400
Date: Fri, 6 May 2005 12:34:28 +0200
From: Jan Kara <jack@suse.cz>
To: Nauman <mailtonauman@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXT2-FS Error (ext2_new_block) Where is this comming from?? can anyone help
Message-ID: <20050506103428.GE25677@atrey.karlin.mff.cuni.cz>
References: <3cac075b05050423135a8efa2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cac075b05050423135a8efa2@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> I have set up a Block Device over a SCSI drive. I write data to the
> actual target drive after writing same blocks in my RAMDISK. I am
> using RAMDISK of 2 GB. once the allcoated blocks of my RAMDISK are
> full i start freeing those blocks (WRITE THROUGH). at  this point i
> get this message during Write operations
> Ext2 FS- Error: ext2_new_block : Allocating blocks in System zone. <block_nr>
> Is this some sort of calculation error or some other configuration problem?? 
  This message means that ext2_new_block() got somehow tricked to
allocate a block in the place where inode tables, bitmaps or
superblocks are. I.e. the filesystem is probably corrupted. It's hard to
tell how that happened - you use some standard tools to create the above
described setup or it's just your own kernel hack?

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
