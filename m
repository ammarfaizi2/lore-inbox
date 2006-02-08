Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWBHWFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWBHWFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWBHWFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:05:21 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:502 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751138AbWBHWFU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:05:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=M0u2O38zmcz3jz6DFEWfIQ8bvsN50VQYPDVMK1uzOfaWAzlOkZklfjiAbLZ9++1cq9xPMIqfyA/J1mL79Vd/E4W+RYYumFwtQRbm8rBP1fDLuw5EkdEMOtZEn2i15UEO06SR2DbQ7YSHG02uMGAqk8TMnQBYTiYStiuV9CCZ1YE=
Message-ID: <a4403ff60602081405r716d9026r67ddd9d744cdabdb@mail.gmail.com>
Date: Wed, 8 Feb 2006 15:05:19 -0700
From: David Wilk <davidwilk@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: data retention after mkfs.ext3
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We deploy a linux system by rsync'ing a filesystem off of a squashfs
FS on a CD.  The deployment is automated and always involves an
mkfs.ext3 prior to any file copy.  We have had some reports that tend
to indicate that some of the data from a previous install (of the same
method) is corrupting at least some of the files on a new install. 
Old settings and random behavior has been seen, and breaking the RAID1
logical drive and rebuilding prior to install has always fixed the
issue.

 It is my impression that mkfs.ext3 will make any existing data on a
block device invisiable to the new ext3 FS.  Is it possible that if
the old FS is similar enough to the new one that the old data could
somehow influence the new files written to a new ext3 FS?

 I know this *should* be impossible, but is it truly impossible?
