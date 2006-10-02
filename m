Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWJBKak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWJBKak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWJBKak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:30:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:49367 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750741AbWJBKaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:30:39 -0400
Date: Mon, 2 Oct 2006 12:29:59 +0200
From: Holger Macht <hmacht@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net,
       ismail@pardus.org.tr
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Message-ID: <20061002102959.GA21558@homac>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Alessandro Guido <alessandro.guido@gmail.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net,
	ismail@pardus.org.tr
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061001171912.b7aac1d8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061001171912.b7aac1d8.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 01. Oct - 17:19:12, Andrew Morton wrote:
> On Sat, 30 Sep 2006 19:08:10 +0200
> Alessandro Guido <alessandro.guido@gmail.com> wrote:
> 
> > Make the sony_acpi use the backlight subsystem to adjust brightness value
> > instead of using the /proc/sony/brightness file.
> > (Other settings will still have a /proc/sony/... entry)
> 
> umm, OK, but now how do I adjust my screen brightness? ;)
> 
> I assume that cute userspace applications for controlling backlight
> brightness via the generic backlight driver either exist or are in
> progress?  What is the status of that?

Most applications use HAL as a backend for display brightness these
days. HAL still supports the old interface in /proc for the different
brightness drivers, though, but the conversion to the new interface is on
my TODO and I will do it this week. So userspace should have fixed this
soon, so go ahead ;-)

Btw, there's a patchset from Matthew Garrett [1] sent some time ago which
also converts the asus_acpi, ibm_acpi and the toshiba_acpi drivers.

Regards,
	Holger

[1] http://lkml.org/lkml/2006/4/18/28
