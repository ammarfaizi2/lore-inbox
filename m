Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWHDDUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWHDDUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWHDDUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:20:54 -0400
Received: from xenotime.net ([66.160.160.81]:53917 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030307AbWHDDUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:20:54 -0400
Date: Thu, 3 Aug 2006 20:23:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Theuns Verwoerd <theuns@bluewatersys.com>
Cc: r.marek@sh.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001/001] I2C: AD7414 I2C chip driver for Linux-2.6.17.7
Message-Id: <20060803202336.07c2b2a2.rdunlap@xenotime.net>
In-Reply-To: <44D28C60.1000304@bluewatersys.com>
References: <44D28C60.1000304@bluewatersys.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2006 11:53:04 +1200 Theuns Verwoerd wrote:

> AD7414 Temperature Sensor I2C driver.  I2C chip driver for the Analog
> Devices AD7414 device, exposes raw and decoded registers via sysfs.
> Signed-off-by: Theuns Verwoerd <theuns.verwoerd@bluewatersys.com>
> ---
> Tested on a custom EP9315-based board developed in-house. Fairly trivial
> driver; really just exposes the raw registers and temperature reading
> to userspace.
> Patch is relative to stock Linux-2.6.17.7

Patches should be made against latest mainline kernel, e.g.,
2.6.18-rc3 (unless they are specifically for an -mm patch),
although it probably doesn't matter in this case.

> [This is my first go at a kernel submission, so feel free to point out 
> anything
> that should be done differently]
> ---
> diff -uprN -X linux-2.6.17.7-vanilla/Documentation/dontdiff 
> linux-2.6.17.7-vanilla/drivers/i2c/chips/ad7414.c 
> linux-2.6.17.7/drivers/i2c/chips/ad7414.c
> --- linux-2.6.17.7-vanilla/drivers/i2c/chips/ad7414.c    1970-01-01 
> 12:00:00.000000000 +1200
> +++ linux-2.6.17.7/drivers/i2c/chips/ad7414.c    2006-08-04 
> 10:28:37.000000000 +1200

1/  Thunderbird is breaking (splitting) your lines for you.  :(
See if http://mbligh.org/linuxdocs/Email/Clients/Thunderbird
helps any.  Try sending a patch to yourself and test if you
can apply it.  Or use a different mail client/app.
Those 7 lines above should be 3 lines.
You may need to unset some "flowed" attribute in tbird
(I'm not sure of its full, correct name.)

2/  Either thunderbird is converting tabs to spaces or the
driver source does not contain tabs -- just lots of spaces.
Please indent struct fields with one tab, embedded struct fields
with 2 tabs, etc.

3/  Macro continuation lines should be indented.

4/  sysfs files should contain only one value per file.  Use
multiple files for multiple values.

5/  Code labels should not be indented or maybe indented one space,
and certainly not indented more than the following source lines.

6/  device_create_file() and friends can return errors.  They need
to be checked for success/fail.

7/  Header files should be included in linux/ alpha order, then
asm/ alpha order, then local.h files unless there are reasons
that this order won't work.
(Yes, only linux/ applies here.)


---
~Randy
