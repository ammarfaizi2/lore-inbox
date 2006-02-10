Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWBJQCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWBJQCf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWBJQCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:02:34 -0500
Received: from mail.astral.ro ([193.230.240.11]:9143 "EHLO mail.astral.ro")
	by vger.kernel.org with ESMTP id S932151AbWBJQCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:02:34 -0500
Message-ID: <43ECB91E.6060109@astral.ro>
Date: Fri, 10 Feb 2006 18:02:38 +0200
From: Imre Gergely <imre.gergely@astral.ro>
Organization: Astral Telecom SA
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: disabling libata
References: <43EC97C6.10607@astral.ro> <20060210141130.GE28676@harddisk-recovery.com> <43ECA035.5040302@astral.ro> <20060210142224.GF28676@harddisk-recovery.com>
In-Reply-To: <20060210142224.GF28676@harddisk-recovery.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Erik Mouw wrote:
> On Fri, Feb 10, 2006 at 04:16:21PM +0200, Imre Gergely wrote:
>> Erik Mouw wrote:
>>> On Fri, Feb 10, 2006 at 03:40:22PM +0200, Imre Gergely wrote:
>>>> i have a SATA hardisk, and am using FC4 with default kernel
>>>> (2.6.14-1.1644_FC4). i was wondering if it's possible to tell the kernel to use
>>>> the old ATA driver with SATA support instead of libata, for my harddisk to
>>>> appear as hdX, and not sdX.
>>> Why would you want to do that? SATA are driven by libata and the disks
>>> turn up as SCSI devices. There's no way around that (yet).
>> if i recompile the kernel, and leave out the libata part, and compile in
>> support for SATA, under ATA, the harddisks turn up as normal IDE devices (ie
>> hde, hdf, etc). i would like that without recompiling. if it's possible of course.
> 
> Yes, I know that's possible for some SATA adapters, but my question is
> why would you want to do that? The SATA support in the IDE subsystem is
> deprecated, you should really use libata.
> 
> 
> Erik
> 

maybe it's just me... but it looks like if as SCSI device the whole thing is
slower than with IDE. i haven't tested it yet, but as sda the system load is
very high, i did some tests with dd, and the CPU usage is always at 98-100%.
and when i'm copying something to another disk, the other programs barely move,
sometimes even the mouse gets stuck. i dunno where this is coming from. i
thought i try with the old driver.

maybe if you could give me some hints about how to test the whole thing, i
could post some results. i know that driver change isn't the answer, but i
still wanted to know if one can switch between the old and the libata driver
without recompiling (with some boot parameters to the kernel perhaps).


