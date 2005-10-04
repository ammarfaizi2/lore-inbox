Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVJDMOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVJDMOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVJDMOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:14:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:31161 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932398AbVJDMOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:14:02 -0400
Subject: Re: thinkpad suspend to ram and backlight
From: Timo Hoenig <thoenig@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Stefan Seyfried <seife@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051004120334.GE17458@elf.ucw.cz>
References: <20051002175703.GA3141@elf.ucw.cz> <43410149.9070007@suse.de>
	 <1128427214.14551.15.camel@nouse.suse.de>
	 <20051004120334.GE17458@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 14:13:09 +0200
Message-Id: <1128427990.14551.20.camel@nouse.suse.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-10-04 at 14:03 +0200, Pavel Machek wrote:

> > When eying the display precisely it seems to be switched off for a short
> > moment once the system enters S3 but then gets turned on again.
> 
> Yes, same with radeonfb here.
> 
> I use
> 
> #!/bin/bash
> radeontool light off
> echo 3 > /proc/acpi/sleep
> radeontool light on

Well, if we're already discussing workarounds which shouldn't be needed.
With ibm_acpi loaded this should help:

        #!/bin/bash
        echo lcd_disable > /proc/acpi/ibm/video
        echo 3 > /proc/acpi/sleep
        echo lcd_enable > /proc/acpi/ibm/video

> ...and it works most of the time. Sometimes screen is corrupted after
> resume, another suspend/resume cycle cures that. (Strange!)

I haven't encountered screen corruption until now.

> 								Pavel

   Timo

