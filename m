Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbTKNETB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 23:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTKNETA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 23:19:00 -0500
Received: from ssa8.serverconfig.com ([209.51.129.179]:19405 "EHLO
	ssa8.serverconfig.com") by vger.kernel.org with ESMTP
	id S262149AbTKNES7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 23:18:59 -0500
From: "Joseph D. Wagner" <theman@josephdwagner.info>
To: linux-kernel@vger.kernel.org
Subject: Adding Deprecated Attribute Tags
Date: Thu, 13 Nov 2003 22:18:57 +0600
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311132218.57222.theman@josephdwagner.info>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ssa8.serverconfig.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - josephdwagner.info
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I formally request that the struct ext2_dir_entry and ext3_dir_entry in the 
ext2_fs.h and ext3_fs.h files be changed to add the below specified 
attributes:

struct ext2_dir_entry {
        __u32   inode;                  /* Inode number */
        __u16   rec_len;                /* Directory entry length */
        __u16   name_len;               /* Name length */
        char    name[EXT2_NAME_LEN];    /* File name */
} __attribute__ ((deprecated));

struct ext3_dir_entry {
        __u32   inode;                  /* Inode number */
        __u16   rec_len;                /* Directory entry length */
        __u16   name_len;               /* Name length */
        char    name[EXT3_NAME_LEN];    /* File name */
} __attribute__ ((deprecated));

This will aid future development and debugging to ensure that everyone uses 
the new struct ext2_dir_entry_2 and can take advantage of the additional 
fields.

Joseph D. Wagner

