Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVJYNaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVJYNaO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 09:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVJYNaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 09:30:13 -0400
Received: from bromo.msbb.uc.edu ([129.137.3.146]:9689 "HELO bromo.msbb.uc.edu")
	by vger.kernel.org with SMTP id S1751275AbVJYNaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 09:30:13 -0400
To: linux-kernel@vger.kernel.org
Subject: W2100Z and acpi
Message-Id: <20051025132844.8C1431DC0BB@bromo.msbb.uc.edu>
Date: Tue, 25 Oct 2005 09:28:44 -0400 (EDT)
From: howarth@bromo.msbb.uc.edu (Jack Howarth)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     Have there been any reports of issues with acpi on the Sun
dual Opteron W2100Z for any of the 2.6.12 or 2.6.13 kernels. We
were suffering a slew of random shutdowns yesterday on our machine
running Fedora Core 4 and their 2.6.12-1.1456_FC4smp kernel build.
The machine which had acpi enabled in chkconfig was randoming shutting
down with errors of...

Oct 22 05:01:23 XXXX  kernel: Critical temperature reached (68 C), shutting down.
Oct 22 05:01:23 XXXX  kernel: Critical temperature reached (68 C), shutting down.

...in the system log. We have switched to their latest 2.6.13-1.1532_FC4smp
kernel and the random thermal shutdowns have ceased. I still plan to update
the BIOS using the Supplemental 2.1 cd from Sun today, but was wondering
if this was a known problem. I am assuming that the errora above have to
be from acpi. Also, looking in /proc/acpi/thermal_zone/THRS, I see...

cat /proc/acpi/thermal_zone/THRS/trip_points
critical (S5):           65 C

and

cat /proc/acpi/thermal_zone/THRS/temperature
temperature:             43 C

under the latest kernel with both CPUs running at 100% during numerical
calculations. I am unclear how exactly the temperature value is determined.
I tried installing lm_sensors but unfortunately the required driver for
the fan/temp control chipset doesn't exist yet for the W2100Z. Thanks in
advance for any advice on debugging this further so we don't run into
it again.
                            Jack
