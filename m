Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319274AbSHGTcQ>; Wed, 7 Aug 2002 15:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319276AbSHGTcQ>; Wed, 7 Aug 2002 15:32:16 -0400
Received: from zeus.kernel.org ([204.152.189.113]:20115 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S319274AbSHGTcO>;
	Wed, 7 Aug 2002 15:32:14 -0400
Date: Wed, 7 Aug 2002 15:35:49 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: PCI hotplug resource reservation 
In-Reply-To: <13500.1028746964@redhat.com>
Message-ID: <Pine.LNX.4.33.0208071522570.21045-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, David Woodhouse wrote:

>
> scottm@somanetworks.com said:
> >
> >   On power-up, the system must be automatically configured so that
> > each device's IO and memory functions occupy mutually-exclusive address
> >
>
> Device not bridge?

My take is that a bridge is a PCI device which just happens to have
extra BARs that must be considered.  Skimming through "Chapter 24:
PCI-to-PCI Bridge" of "PCI System Architecture, 4th Edition" (most
notably page 568 - "Address Decode-Related Registers"), the words
"mutually-exclusive" occur every time resource ranges are discussed.

I think the implications are pretty strong that programming bridges
with conflicting ranges will result in undefined behaviour.  Even if
it did work, doing so also has the potential to open us up to new
classes of bridge hardware bugs that no one has seen before.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

