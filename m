Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135335AbRDLVwv>; Thu, 12 Apr 2001 17:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135353AbRDLVwl>; Thu, 12 Apr 2001 17:52:41 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:7942
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S135335AbRDLVw2>; Thu, 12 Apr 2001 17:52:28 -0400
Date: Thu, 12 Apr 2001 14:52:22 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: schwidefsky@de.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
In-Reply-To: <3AD622AB.5F0A061B@linux-ide.org>
Message-ID: <Pine.LNX.4.10.10104121448520.4564-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay but what will be used for a base for hardware that has critical
timing issues due to the rules of the hardware?

I do not care but your drives/floppy/tapes/cdroms/cdrws do:

/*
 * Timeouts for various operations:
 */
#define WAIT_DRQ        (5*HZ/100)      /* 50msec - spec allows up to 20ms */
#ifdef CONFIG_APM
#define WAIT_READY      (5*HZ)          /* 5sec - some laptops are very slow */
#else
#define WAIT_READY      (3*HZ/100)      /* 30msec - should be instantaneous */
#endif /* CONFIG_APM */
#define WAIT_PIDENTIFY  (10*HZ) /* 10sec  - should be less than 3ms (?), if all ATAPI CD is closed at boot */
#define WAIT_WORSTCASE  (30*HZ) /* 30sec  - worst case when spinning up */
#define WAIT_CMD        (10*HZ) /* 10sec  - maximum wait for an IRQ to happen */
#define WAIT_MIN_SLEEP  (2*HZ/100)      /* 20msec - minimum sleep time */

Give me something for HZ or a rule for getting a known base so I can have
your storage work and not corrupt.

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

