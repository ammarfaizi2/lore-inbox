Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbSLDR5Q>; Wed, 4 Dec 2002 12:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbSLDR5Q>; Wed, 4 Dec 2002 12:57:16 -0500
Received: from host194.steeleye.com ([66.206.164.34]:30470 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266996AbSLDR5N>; Wed, 4 Dec 2002 12:57:13 -0500
Message-Id: <200212041804.gB4I4g803144@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Greg KH <greg@kroah.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>, mochel@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BKPATCH] bus notifiers for the generic device model 
In-Reply-To: Message from Greg KH <greg@kroah.com> 
   of "Wed, 04 Dec 2002 09:56:03 PST." <20021204175602.GC27780@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Dec 2002 12:04:41 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

greg@kroah.com said:
> But doesn't the bus specific core know when drivers are attached, as
> it was told to register or unregister a specific driver?  So I don't
> see why this is really needed. 

The problem is that the bus specific core registration no-longer knows if the 
probes succeeded or failed (and if they did, what devices were attached), 
since probing is controlled by the base core.

What the bus needs to know is when a driver attaches to a specific device (and 
what device it has attached to).

Unless you have a better way of getting the attachment information out of the 
bus after the base probes have executed, a notifier seemed to be the simplest 
thing.

James


