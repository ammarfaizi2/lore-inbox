Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283780AbRLWTOR>; Sun, 23 Dec 2001 14:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283783AbRLWTOH>; Sun, 23 Dec 2001 14:14:07 -0500
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:33623
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S283780AbRLWTN4>; Sun, 23 Dec 2001 14:13:56 -0500
Message-Id: <200112231913.fBNJDgt01933@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH: NEW ARCHITECTURE FOR 2.5] support for NCR voyager 
 343x/345x/4100/51xx architecture
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 13:13:42 -0600
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NCR voyager architecture is essentially a precursor of the intel APIC one. 
 The Voyager systems support from one to eight "processor" slots which take 
big cards with 1-4 486-686 processors.  The difficulties for linux are mainly 
that the Interrupts are delivered through the VIC architecture of 8 8259 PIC 
dyads (so some processors accept interrupts and some don't); the 8259 dyads 
are accessible only locally to the interrupt handling processor, so global 
interrupt enable and disable becomes a difficult concept.

Since the architecture support depends fairly intimitely on the existing i386 
code, I've slotted it into the i386 architecture directory rather than trying 
to create a separate one.

The architecture was released publicly in March 2001 for both the 2.2 and 2.4 
kernel series.  It has a fairly small user base.

The diffs are ~151k, so I refer to them by URL rather than bunging up the 
mailing list.  The URL is

http://www.hansenpartnership.com/voyager/files/voyager-2.5.1.diff

All comments welcome.

James Bottomley


