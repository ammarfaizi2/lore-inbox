Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVHSMlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVHSMlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 08:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbVHSMlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 08:41:23 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:54175
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932501AbVHSMlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 08:41:22 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Jens Axboe'" <axboe@suse.de>, "'Jon Escombe'" <lists@dresco.co.uk>
Cc: "'Pavel Machek'" <pavel@suse.cz>, "'Adam Goode'" <adam@evdebs.org>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       "'hdaps devel'" <hdaps-devel@lists.sourceforge.net>
Subject: RE: [Hdaps-devel] Re: HDAPS, Need to park the head for real
Date: Fri, 19 Aug 2005 06:41:11 -0600
Message-ID: <002b01c5a4bb$484db920$a20cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20050819102314.GN6273@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Aug 19 2005, Jon Escombe wrote:
> > For hard disk protection, I prefer the idea of the userspace code
> > thawing the drive based on current accelerometer data, rather than
> > simply waking up after x seconds (maybe you're running for
> a bus rather
> > than falling off a table)...
> >
> > To get the best of both worlds, could we maybe take a
> watchdog timer
> > approach, and have the timeout reset by the userspace component
> > periodically re-requesting freeze?
>
> That would work, you can just define the semantics to be that echo
> foo > frozen would add foo seconds to the timeout (or thaw
> it, if foo is
> 0).

This one is really a hard one to ask for. I mean, if we can make it the way
that it will keep knowing that the accel is changing heavily, then it would
be great. This way we/users can implement other actions as well, not only
for HDAPS, but the fact of kicking any other daemon that we want to. i.e.
The theft system, kicking in laptop_mode if there is soft vibration for a
certain amount of seconds, making festival tell you that the PC is being
moved... Anything!

The fact is also that if we would only make a driver for HDAPS, we could
simply make it freeze for 8 seconds and done. How often do you drop the
laptop? How long does it take even if it rolls down the stairs? 4 Seconds
tops? But then, the driver would be boring. ;-)

.Alejandro

