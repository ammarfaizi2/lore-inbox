Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262143AbSJFTfH>; Sun, 6 Oct 2002 15:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262144AbSJFTfG>; Sun, 6 Oct 2002 15:35:06 -0400
Received: from adsl-66-136-198-157.dsl.austtx.swbell.net ([66.136.198.157]:3972
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S262143AbSJFTfD>; Sun, 6 Oct 2002 15:35:03 -0400
Subject: Re: QLogic Linux failover/Load Balancing ER0000000020860
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Michael Clark <michael@metaparadigm.com>
Cc: jbradford@dial.pipex.com, linux-kernel@vger.kernel.org
In-Reply-To: <3DA02BF2.2040506@metaparadigm.com>
References: <200210061103.g96B3mlO001484@darkstar.example.net>
	 <3DA02BF2.2040506@metaparadigm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1033933235.2436.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 06 Oct 2002 14:40:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 07:26, Michael Clark wrote:
> >>I see. ATM I'm using 2.4.19, but would like to get to 2.4.20, because of
> >>the TG3 fixes. 
> > 
> > 
> > You were probably thinking of CONFIG_SCSI_MULTI_LUN above, then.  That causes the kernel to probe all LUNs instead of just LUN 0, which is the default due to a lot of broken devices to respond to all LUNs instead of just LUN 0.  The sparse LUN option is in addition to that in 2.5.x.
> > 
> > If this is for a live server, it might be easiest to hard code the LUNs you need it to probe in to 2.4.x for now, and wait until 2.6.x for proper support.
> 
> 2.4 supports sparse lun scanning, although it is not enabled
> dynamically and requires add a BLIST_SPARSELUN flag for your device
> in the device_list array in drivers/scsi/scsi_scan.c

I worked with Andrea to get the PV660F doing this, because it was not
working correctly, so I know of what you speak. I'll get that info from
/proc/scsi/scsi and then fix it up and see if that does it. 

> You just need to get the Vendor and Model info from /proc/scsi/scsi
> 
> I am using qlogic 2300s with sparse luns working fine on 2.4.18.

using the LB static bindings and *failover* still works?


> ~mc
> 
