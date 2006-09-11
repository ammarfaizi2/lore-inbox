Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWIKPNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWIKPNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWIKPNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:13:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18858 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964843AbWIKPNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:13:19 -0400
Date: Mon, 11 Sep 2006 17:13:03 +0200
From: Stefan Seyfried <seife@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>,
       ACPI mailing list <linux-acpi@vger.kernel.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: x60 - spontaneous thermal shutdown
Message-ID: <20060911151303.GD17655@suse.de>
References: <20060904214059.GA1702@elf.ucw.cz> <20060911094607.GA14095@suse.de> <200609111610.37514.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200609111610.37514.rjw@sisk.pl>
X-Operating-System: openSUSE 10.2 (i586) Alpha4, Kernel 2.6.18-rc5-git6-2-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 04:10:36PM +0200, Rafael J. Wysocki wrote:
> On Monday, 11 September 2006 11:46, Stefan Seyfried wrote:
> > On Mon, Sep 04, 2006 at 11:40:59PM +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > x60 shut down after quite a while of uptime, in period of quite heavy
> > > load:
> > > 
> > > Sep  4 23:33:01 amd kernel: ACPI: Critical trip point
> > > Sep  4 23:33:01 amd kernel: Critical temperature reached (128 C), shutting down.
> > > Sep  4 23:33:01 amd shutdown[32585]: shutting down for system halt
> > > Sep  4 23:34:42 amd init: Switching to runlevel: 0
> > > 
> > > I do not think cpu reached 128C, as I still have my machine... Did
> > > anyone else see that?
> > 
> > my usual suspect: use ec_intr=0.
> 
> Is this a kernel command line parameter?

yes.

seife@susi:~> dmesg | grep "^ACPI: EC"
ACPI: EC polling mode.
seife@susi:~> cat /proc/cmdline
root=/dev/hda5 vga=0x317 sysrq=yes resume=/dev/hda1  splash=silent showopts ec_intr=0

with ec_intr=1 (default), you'll get "ACPI: EC interrupt mode."

> I'm having some suspend/resume related problems on HPC 6325 now, and they
> seem to be related to the embedded controller.

Well, polling mode is always on my "things to try"-list for those unspecified
ACPI failures :-)
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
