Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTDEUtf (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 15:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTDEUtf (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 15:49:35 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:41744
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262656AbTDEUtc (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 15:49:32 -0500
Date: Sat, 5 Apr 2003 12:56:23 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Markus Kossmann <markus.kossmann@inka.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise 202XX: neither IDE port enabled
In-Reply-To: <200304051721.21663.markus.kossmann@inka.de>
Message-ID: <Pine.LNX.4.10.10304051254500.29290-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is messy because there is no way to commit parameters passed to change
the contents of static initdata, iirc.  However I need to think about this
more.

Cheers,

On Sat, 5 Apr 2003, Markus Kossmann wrote:

> On Saturday 05 April 2003 13:02, Andre Hedrick wrote:
> > It is designed to allow you to overide a FastTrack BIOS that disables a
> > few items in pci-config space.  Regardless if you have a FastTrack or
> > Ultra, if enabled the device can be registered.  If you have a FastTrack
> > and want to use ata-raid by Arjan V. and not the OEM scsi binary driver,
> > you must enable the override.  If you want to use the OEM scsi binary
> > driver with FastTrack, do not set the override.  Ultra's do not care.
> > If they do it is a BUG!
> >
> Wouldn't it be better to have the CONFIG_PDC20XXX_FORCE option as kernel 
> parameter , which is settable at boot time ? 
> According to Murphys Law you either get a precompiled kernel with that option 
> disabled but you want/have to use Arjans drivers. Or the Option is enabled 
> but you prefer to use the driver from Promise.   
> -- 
> Markus Kossmann markus.kossmann@inka.de
> 

Andre Hedrick
LAD Storage Consulting Group

