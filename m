Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSHDK1H>; Sun, 4 Aug 2002 06:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318144AbSHDK1H>; Sun, 4 Aug 2002 06:27:07 -0400
Received: from [129.187.202.12] ([129.187.202.12]:29683 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317742AbSHDK1H>; Sun, 4 Aug 2002 06:27:07 -0400
Date: Sun, 4 Aug 2002 12:30:36 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.30-dj1 (sort of)
In-Reply-To: <20020802171252.M25761@suse.de>
Message-ID: <Pine.NEB.4.44.0208041228060.1422-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

the part of -dj1 below is obviously wrong (and it causes a compile error).
After removing it the file compiles.

--- linux-2.5.30/fs/jffs2/dir.c	2002-08-01 22:16:15.000000000 +0100
+++ linux-2.5/fs/jffs2/dir.c	2002-08-02 15:50:33.000000000 +0100
@@ -718,6 +718,7 @@ static int jffs2_rename (struct inode *o
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(old_dir_i->i_sb);
 	struct jffs2_inode_info *victim_f = NULL;
 	uint8_t type;
+	struct jffs2_inode_info *victim_f = NULL;

 	/* The VFS will check for us and prevent trying to rename a
 	 * file over a directory and vice versa, but if it's a directory,

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

