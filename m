Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262057AbREQRFO>; Thu, 17 May 2001 13:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262059AbREQREy>; Thu, 17 May 2001 13:04:54 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:64405 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S262057AbREQREp>; Thu, 17 May 2001 13:04:45 -0400
Date: Thu, 17 May 2001 10:03:32 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: LANANA: To Pending Device Number Registrants
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Miles Lane <miles@megapathdsl.net>, Tim Jansen <tim@tjansen.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <0ac601c0def3$4e4f1a40$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <047801c0dd95$231331e0$6800000a@brownell.org>
 <01051601562302.01000@cookie> <990079966.25105.1.camel@agate>
 <01051714073800.01598@idun>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For identifying this is probably the right approach. However identifying is 
> not enough, as the ioctl discussion has shown. Capabilities are needed. How 
> can the device registry provide that information ? 

My feedback on "device registry 0.1" was that I really liked the
approach of _modeling_ devices by attributes ... which reminded me
of the good things in "attribute based naming" a la X.500/LDAP
models.  I suspect 0.2 went too far, using XML to expose those
attributes to userspace ... :)

If each device had a directory node, those directory nodes could be
grouped as a "registry" ... the directory contents would list the various
bus-specific or type-specific capabilities/attributes.  Would those
directory nodes be the /dev/... or /devfs/... nodes?  I suspect not.


>    If we register it together 
> with the device, we might spend a lot of resources needlessly and can't deal 
> with devices whose capabilities change dynamically.

So obviously such a registry should query the drivers/busses directly.


> In addition how do we export the information ? Proc ?

I think Tim has some ideas here, given a patch I scanned recently...

- Dave


