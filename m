Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWECP53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWECP53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWECP53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:57:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48009 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030228AbWECP52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:57:28 -0400
Date: Wed, 03 May 2006 11:57:26 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Advanced XIP File System
In-reply-to: <6934efce0605030845o6d313681x6b89bef71c28b3a9@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jared Hulbert <jaredeh@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Josh Boyer <jwboyer@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0605031151120.28543@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
 <625fc13d0605021756v7a8e0d7p1e9d8e4c810bc092@mail.gmail.com>
 <Pine.LNX.4.64.0605022316550.28543@localhost.localdomain>
 <625fc13d0605030341h2a105f49r2b1b610547e30022@mail.gmail.com>
 <1146658275.20773.8.camel@pmac.infradead.org>
 <6934efce0605030845o6d313681x6b89bef71c28b3a9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006, Jared Hulbert wrote:

> > We
> > only need to mark those pages as absent in the page tables if we ever
> > schedule to userspace while the flash is in a mode other than read mode.
> > Then handle the page fault by switching the flash back or waiting for
> > it.
> 
> Where would we do this?  In each MTD driver?  A new generic aops function?

First, is it worth it?

IOW, are there real setups out there wishing to have user space XIP 
while the kernel itself isn't XIP?

Because right now you only need to turn on CONFIG_MTD_XIP for XIP user 
space to just work, regardless of whether the kernel itself is XIP or 
not.  And of course CONFIG_MTD_XIP is mandatory if you want to write to 
flash with a XIP kernel.


Nicolas
