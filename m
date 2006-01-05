Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWAEW2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWAEW2d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWAEW2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:28:33 -0500
Received: from motgate.mot.com ([129.188.136.100]:56768 "EHLO motgate.mot.com")
	by vger.kernel.org with ESMTP id S1751444AbWAEW2b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:28:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-pm] [patch] pm: fix runtime powermanagement's /sysinterface
Date: Thu, 5 Jan 2006 17:28:28 -0500
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD6B@de01exm64.ds.mot.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-pm] [patch] pm: fix runtime powermanagement's /sysinterface
Thread-Index: AcYSQzA3Q3J/D/XKQuufUeuHa4Y+mQAA2kOQ
From: "Preece Scott-PREECE" <scott.preece@motorola.com>
To: "Pavel Machek" <pavel@ucw.cz>,
       "Patrick Mochel" <mochel@digitalimplant.org>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux-pm mailing list" <linux-pm@lists.osdl.org>,
       "kernel list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Not sure if this is the kind of example you're looking for, but...

We do have devices that may need to stay alive even though the processor has been suspended - for instance, we keep the display backlight on for human-useful periods following the last keypress, but most of the system can be shut down as soon as the work driven from the keypress is finished. The display needs to be able to maintain itself without the processor's help.

Scott

-----Original Message-----
From: linux-pm-bounces@lists.osdl.org [mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Pavel Machek
Sent: Thursday, January 05, 2006 3:55 PM
To: Patrick Mochel
On Èt 05-01-06 13:42:33, Patrick Mochel wrote:
> 

> I have a firewire controller in a desktop system, and a ATI Radeon in 
> a
> T42 that support D1 and D2..

Ok, now we have a concrete example. So Radeon supports D1. But putting radeon into D1 means you probably want to blank your screen and turn the backlight off; that takes *long* time anyway. So you can simply put your radeon into D3 and save a bit more power.

So yes, Radeon supports D1, but we probably do not want to use it.

[You may still want to do D1 on radeon for debugging/testing/something. Fine, but we are trying to build power-management infrastructure, not debugging one.]

								Pavel
--
Thanks, Sharp!
