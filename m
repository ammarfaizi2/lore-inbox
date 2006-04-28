Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWD1NOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWD1NOJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 09:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWD1NOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 09:14:09 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:33328 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030389AbWD1NOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 09:14:08 -0400
In-Reply-To: <Pine.LNX.4.58.0604281334080.16832@sbz-30.cs.Helsinki.FI>
Subject: Re: [PATCH] s390: Hypervisor File System
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: akpm@osdl.org, ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF5CFD94E3.B2AD7C3A-ON4225715E.0048000A-4225715E.0048B51D@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Fri, 28 Apr 2006 15:14:09 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 28/04/2006 15:15:13
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote on 04/28/2006 12:36:59 PM:
>
> > +static struct dentry *update_file_dentry;
> > +static struct file_operations hypfs_file_ops;
> > +static struct file_system_type hypfs_type;
> > +static struct super_operations hypfs_s_ops;
> > +static time_t last_update_time = 0;   /* update time in seconds
> since 1970 */
> > +static DEFINE_MUTEX(hypfs_lock);
>
> These should be per-superblock and not global, right?

Yes! update_file_dentry, last_update_time and hypfs_lock
should be per-superblock. I will change this!

hypfs_file_ops, hpyfs_type and hypfs_s_ops should remain
global, since this will be the same for all super blocks.

Michael

