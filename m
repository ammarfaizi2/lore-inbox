Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSFXSJX>; Mon, 24 Jun 2002 14:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSFXSJW>; Mon, 24 Jun 2002 14:09:22 -0400
Received: from host194.steeleye.com ([216.33.1.194]:49414 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S314602AbSFXSJU>; Mon, 24 Jun 2002 14:09:20 -0400
Message-Id: <200206241809.g5OI9Ds02886@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'David Brownell'" <david-b@pacbell.net>,
       "'Nick Bellinger'" <nickb@attheoffice.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: driverfs is not for everything! (was: [PATCH] /proc/scsi/map ) 
In-Reply-To: Message from "Grover, Andrew" <andrew.grover@intel.com> 
   of "Mon, 24 Jun 2002 10:35:53 PDT." <59885C5E3098D511AD690002A5072D3C02AB7F53@orsmsx111.jf.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Jun 2002 14:09:13 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrew.grover@intel.com said:
> If a device can be accessed by multiple machines concurrently, it
> should not be in driverfs. 

On that argument, we'll eliminate almost all Fibre Channel devices!

I think the qualification for appearing in driverfs is actually possessing a 
driver.  Therefore, we accept FC and iSCSI.  Things which appear as 
FileSystems are debatable, but not anything which has a real device driver.

> We need a device tree to do PM. If driverfs's PM capabilities are hurt
> because it doesn't stay true to that, then the featureitis has gone
> too far. 

Perhaps it's more a question of whether power management belongs as an every 
unit item in driverfs.  As you say, we get problems where the device is shared 
between multiple computers.

James


