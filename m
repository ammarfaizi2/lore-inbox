Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135396AbRDMEnD>; Fri, 13 Apr 2001 00:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135397AbRDMEmx>; Fri, 13 Apr 2001 00:42:53 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:54448 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S135396AbRDMEmm>; Fri, 13 Apr 2001 00:42:42 -0400
Date: Thu, 12 Apr 2001 23:52:03 -0500
From: Erik DeBill <edebill@swbell.net>
Subject: Re: k 2.4.2; usb; handspring-visor
In-Reply-To: <0104110852300F.25330@weez>; from weez@freelists.org on Wed,
 Apr 11, 2001 at 08:52:30AM -0500
To: John Madden <weez@freelists.org>, linux-kernel@vger.kernel.org
Message-id: <20010412235203.A30278@austin.rr.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01041109595000.00940@horus.arge> <0104110852300F.25330@weez>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 08:52:30AM -0500, John Madden wrote:
> > Apr  8 23:33:09 horus kernel: hub.c: USB new device connect on bus1/1,
> > assigned device number 5
> > Apr  8 23:33:12 horus kernel: usb_control/bulk_msg: timeout
> > Apr  8 23:33:12 horus kernel: usb.c: USB device not accepting new
> > address=5 (error=-110)
> 
> Funny, I've been getting the same messages (on 2.4.0 and now 2.4.3) for a 
> while now, and I thought the problem was with my Visor.  (...I haven't 
> been able to sync for months...)

Have you tried using the normal UHCI driver, instead of the UHCI
Alternate Driver (JE)?  I know the "alternate" one is default from
Linus, but it's incompatible with the usb-visor driver.  The
maintainer said he'd patch the docs to clear up the confusion, but it
hasn't shown up in the mainstream kernels yet.

In my case, trying to use the visor would actually lock up the
machine, requiring a cold boot.  Switched to the other UHCI driver
and it works fine.

Erik
