Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSGLQtK>; Fri, 12 Jul 2002 12:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316668AbSGLQtJ>; Fri, 12 Jul 2002 12:49:09 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:38922
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316667AbSGLQru>; Fri, 12 Jul 2002 12:47:50 -0400
Date: Fri, 12 Jul 2002 09:47:50 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Kevin P. Fleming" <kpfleming@cox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <3D2EEF88.2070609@cox.net>
Message-ID: <Pine.LNX.4.10.10207120941060.20499-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Kevin P. Fleming wrote:

> I have had plans for a while to add Media Status Notification to the 
> ide-floppy driver, so it can do more intelligent media change 
> management. To do so requires ATA (NOT ATAPI) commands to be issued to 
> the drive(s). How would this work if ide-scsi is being used to talk to 
> the drives? Would ide-scsi have to be taught about removable media and 
> Media Status Notification?

You load up and bloat the SCSI layer the special function to do the
taskfile iops, however since the exported ioctl to permit outside the
driver to grant access has been deleted, you have to add more bloat in
scsi.

The result is having to stagger scsi's queuing layer to deal with
overlap protocols that differ enough to cause major headaches.  But this
is 2.5 so bring out the wrecking balls and give SCSI equal time.


Andre Hedrick
LAD Storage Consulting Group

