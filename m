Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTEYIYp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 04:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbTEYIYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 04:24:45 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:22400 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261454AbTEYIYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 04:24:44 -0400
Date: Sun, 25 May 2003 10:44:05 +0100
From: john@grabjohn.com
Message-Id: <200305250944.h4P9i5Ct000456@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFR] a new SCSI driver
Cc: jgarzik@pobox.com, linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Serial ATA is looming quickly on the horizon.  Both device and host
> controller SATA implementations really lend themselves to behaviors
> that have existed in SCSI for a while.  SATA even defines use of SCSI
> Enclosure Services.

Thinking ahead, by the 2.8 timescale, PATA could well be legacy hardware 
which could be supported only by an 'old' IDE driver, much like we already
have at the moment - I.E. we could remove the current 'old' IDE driver
sometime during the 2.7 timescale, and support SATA only via the SCSI layer.

This would save having any more than the minimum SATA code going in to the
existing IDE driver, and consolidate work in the future.        

The bloat of the SCSI layer in embedded machines might be a concern, but  
then again, maybe it won't - how many embedded machines are going to be   
using SATA, anyway?  Once we move away from spinning disks towards solid
state storage, (which is going to happen first in the embedded market),
will we want to use *ATA or SCSI at all?

John
