Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932710AbVLJHuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbVLJHuO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 02:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbVLJHuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 02:50:14 -0500
Received: from web31715.mail.mud.yahoo.com ([68.142.201.195]:10104 "HELO
	web31715.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932769AbVLJHuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 02:50:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=p3JJ23mkeWwv41GVXncgKguvj6B90YDrWnA1JFzrP8JGaQmSdVIo4Q0FU/mtIx7CyiZagMOL9qpNDRIBIkhQ7UZ+7+x3KqfoAfkaFGWI3bFHiffVrnfUcgNmf7sCc6agJP7QTgK5WNaMpivLDga9Rsq2P87SB6XP5n5Kd2bSBFk=  ;
Message-ID: <20051210075012.87815.qmail@web31715.mail.mud.yahoo.com>
Date: Fri, 9 Dec 2005 23:50:12 -0800 (PST)
From: Bao Zhao <baozhaolinuxer@yahoo.com>
Subject: Re: typo in debugfs code comments?
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051210025720.GA17847@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Greg KH <greg@kroah.com> wrote:

> On Fri, Dec 09, 2005 at 06:01:34PM -0800, Bao Zhao
> wrote:
> >   I think that the comments of debugfs_create_u16
> and
> > debugfs_create_u32 
> > have the copy and paste error.
> >   
> > below is original comments.
> > /**
> >  * debugfs_create_u16 - create a file in the
> debugfs
> > filesystem that is used to read and write a
> unsigned 8
> > bit value.
> >  *
> > 
> > /**
> >  * debugfs_create_u32 - create a file in the
> debugfs
> > filesystem that is used to read and write a
> unsigned 8
> > bit value.
> >  *
> > 
> > It should be "a unsigned 16 bit value" and "a
> unsigned
> > 32 bit value"
> 
> Heh, cut and paste comments :)
> 
> Care to send me a patch, as per
> Documentation/SubmittingPatches to fix
> this up?
> 
> thanks,
> 
> greg k-h
> 

This patch fixes cut and paste error in debugfs.

Signed-off-by: Zhao Bao <baozhaolinuxer@yahoo.com>

---

--- linux-2.6.14.3/fs/debugfs/file.c.orig	2005-12-03
17:39:41.000000000 -0500
+++ linux-2.6.14.3/fs/debugfs/file.c	2005-12-03
17:41:15.000000000 -0500
@@ -98,7 +98,7 @@ static u64 debugfs_u16_get(void
*data)
 DEFINE_SIMPLE_ATTRIBUTE(fops_u16, debugfs_u16_get,
debugfs_u16_set, "%llu\n");
 
 /**
- * debugfs_create_u16 - create a file in the debugfs
filesystem that is used to read and write a unsigned 8
bit value.
+ * debugfs_create_u16 - create a file in the debugfs
filesystem that is used to read and write a unsigned
16 bit value.
  *
  * @name: a pointer to a string containing the name
of the file to create.
  * @mode: the permission that the file should have
@@ -140,7 +140,7 @@ static u64 debugfs_u32_get(void
*data)
 DEFINE_SIMPLE_ATTRIBUTE(fops_u32, debugfs_u32_get,
debugfs_u32_set, "%llu\n");
 
 /**
- * debugfs_create_u32 - create a file in the debugfs
filesystem that is used to read and write a unsigned 8
bit value.
+ * debugfs_create_u32 - create a file in the debugfs
filesystem that is used to read and write a unsigned
32 bit value.
  *
  * @name: a pointer to a string containing the name
of the file to create.
  * @mode: the permission that the file should have



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
