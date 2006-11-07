Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753590AbWKGHEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbWKGHEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 02:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753587AbWKGHEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 02:04:47 -0500
Received: from tag.witbe.net ([81.88.96.48]:8879 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S1753409AbWKGHEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 02:04:46 -0500
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Marc Perkel'" <marc@perkel.com>,
       "'Chris Lalancette'" <clalance@redhat.com>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, <linux-kernel@vger.kernel.org>
Subject: RE: could not find filesystem /dev/root
Date: Tue, 7 Nov 2006 08:04:33 +0100
Organization: AS2917.net
Message-ID: <02e401c7023a$fdcce1d0$4b00a8c0@donald>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AccB/s8G2asG5HiRS9evv+8JcBDivAAO7Q4w
In-Reply-To: <454FCB02.2060907@perkel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > I ran into the same problem when using an FC-6 .config file 
> compiling 2.6.19-rc4.  In my case, the problem was that the 
> configuration options for Serial ATA have changed since 
> 2.6.18 (which the FC-6 config is based on).  I had to 
> manually go in to the config (with make menuconfig) and turn 
> on the SATA device that I have.  What kind of SATA controller 
> do you have, and what does your .config look like?

I also had nearly the same problem when moving from FC5 kernel to a
stock vanilla kernel : FC5 is heavily relying on modules, and my vanilla
kernel was compiled with everything built-in and no modules. 
This is definitely changing the order in which drivers and disks are
discovered
and resulted in drives changing devices :
FC5               Vanilla
/dev/sda   <--->  /dev/sdb
/dev/sdb   <--->  /dev/sdc
/dev/sdc   <--->  /dev/sda

This is a real pain, though people will tell you that udev is supposed
to take care of this... My problem was just that I _don't_ want udev
on my machine...

So, check also this point...

Regards,
Paul

