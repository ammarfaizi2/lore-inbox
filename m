Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbTARWbA>; Sat, 18 Jan 2003 17:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTARWa7>; Sat, 18 Jan 2003 17:30:59 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61706 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265134AbTARWa7>; Sat, 18 Jan 2003 17:30:59 -0500
Date: Sat, 18 Jan 2003 23:39:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Grover <andrew.grover@intel.com>
Subject: Re: Code obfuscation in acpi
Message-ID: <20030118223958.GC21720@atrey.karlin.mff.cuni.cz>
References: <20030118213134.GA8968@elf.ucw.cz> <20030118223210.GA31860@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030118223210.GA31860@gtf.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > #define acpi_driver_data(d)     ((d)->driver_data)
> > 
> > ... very nice for obfuscating code ...
> 
> sysfs-based buses use <foo>_{get,set}_drvdata, which looks exactly the
> same as this here.

I think such wrappers are really bad idea, see for example this: I
thought "what kind of cleverness is going on here,", and it was very
simple in fact.

        else {
                entry->proc_fops = &acpi_thermal_state_fops;
                entry->data = acpi_driver_data(device);
        }


-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
