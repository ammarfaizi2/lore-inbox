Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262916AbVALANg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbVALANg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbVALAJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 19:09:17 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:12749 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S262959AbVALAHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 19:07:16 -0500
Message-ID: <41E46A59.2010205@metaparadigm.com>
Date: Wed, 12 Jan 2005 08:07:53 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Zajkowski <jamesez@umich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sparse LUN scanning - 2.4.x
References: <cs182h$6nl$1@sea.gmane.org>
In-Reply-To: <cs182h$6nl$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Zajkowski wrote:

> Hi there,
>
> We have an Apple Xserve RAID, connected through a FC switch.  The RAID 
> has LUN-masking enabled, such that one of our Linux boxes only gets 
> LUN 1 and not LUN 0.  We're running the 2.4.x kernel series now, since 
> this is under a RHEL envinronment.
>
> The problem is this: since LUN 0 does not show up -- specifically, it 
> can't read the vendor or model informaton -- the kernel SCSI scan does 
> not match with the table to tell the kernel to do sparse LUN 
> scanning... so the RAID does not appear.
>
> I can make the RAID show up by injecting a add-single-device to the 
> SCSI proc layer.  Trivially patching scsi_scan.c to always do sparse 
> scanning works as well.  No hokery with max_scsi_luns or ghost devices 
> works.
>
> I'm considering making a patch to add a kernel option to force sparse 
> scanning.  Is there a better way?
>
Add the Xserve with the BLIST_SPARSELUN flag into the blacklist/quirks 
table in drivers/scsi/scsi_scan.c

~mc
