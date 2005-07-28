Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVG1PqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVG1PqC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVG1PqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:46:01 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:18610 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261468AbVG1PpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:45:13 -0400
To: Andrew Morton <akpm@osdl.org>
cc: Florian Engelhardt <flo@dotbox.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: system freezes for 0.2 to 0.5 seconds when reading /proc/acpi/thermal_zone/THRM/temperature 
In-Reply-To: Your message of "Wed, 27 Jul 2005 23:56:25 PDT."
             <20050727235625.028b7728.akpm@osdl.org> 
Date: Thu, 28 Jul 2005 16:45:08 +0100
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1DyAZI-0006Mh-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the same short freezes with

  cat /proc/acpi/battery/*/{state,info}

and also with the 'acpi' command-line tool.  I'm about to try the the
suggested kernel profiling with -mm3 and will report the results.

Meanwhile:

>>> readprofile -r
>> do i have to activate something special during kernel configuration?
>Set CONFIG_PROFILING=y

That confuses me.  For readprofile support,
Documentation/basic_profiling.txt says

  Add "profile=2" to the kernel command line.

For Oprofile support it says:

  Configure with CONFIG_PROFILING=y and CONFIG_OPROFILE=y

The two together suggest that CONFIG_PROFILING shouldn't be needed for
readprofile.

-Sanjoy
