Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTLZBqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 20:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbTLZBqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 20:46:52 -0500
Received: from lightning.hereintown.net ([141.157.132.3]:61359 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S264444AbTLZBqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 20:46:50 -0500
Subject: GCC 3.4 Heads-up
From: Chris Meadors <clubneon@hereintown.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1072403207.17036.37.camel@clubneon.clubneon.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Dec 2003 20:46:48 -0500
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AZh3y-0006W6-Ar*SYD.XeEzQ8.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know it isn't the recommended compiler, heck it isn't even released
yet, but I was messing around with a GCC 3.4 snapshot, and figured I'd
give compiling the 2.6.0 kernel a shot.

Other than the constant barrage of warnings about the use of compound
expressions as lvalues being deprecated* (mostly because of lines 114,
116, and 117 of rcupdate.h, which is included everywhere), the build
goes very well.

It isn't until the final link that I get an error.  It seems that
something goes funny with the ACPI's use of strcpy.  I get undefined
references to strcpy in:  acpi_bus_generate_event (twice),
acpi_power_add, acpi_thermal_add, and acpi_bus_add.  There may be
additional different locations, but the error output stops there.

As I said, I'm just messing around, and figured I'd let everyone know
what's in the pipeline.  But if it is a simple fix, I'll give any
changes anyone wants to try a shot.

*It also doesn't like cast or conditional expressions as lvalues.

-- 
Chris

