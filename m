Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTEFHQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 03:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTEFHQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 03:16:46 -0400
Received: from 130.146.174.203.mel.ntt.net.au ([203.174.146.130]:42133 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP id S262426AbTEFHQo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 03:16:44 -0400
To: linux-kernel@vger.kernel.org
Subject: CPUFreq sysfs interface MIA?
From: Daniel Pittman <daniel@rimspace.net>
Date: Tue, 06 May 2003 17:29:15 +1000
Message-ID: <873cjsv8hg.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under both 2.5.68 and 2.5.69 the CPUFreq /sys interface seems to be
missing for my machine (IBM A31p), with an Intel 845 Brookdale chipset
and SpeedStep support.

It was certainly present around 2.5.67 or so, but seems to have vanished
since that point. I have not yet tracked down exactly where it went MIA.

Since I couldn't work out from either the documentation or the code if
there should be a /sys/devices/sys/cpu0/cpufreq directory when the code
is compiled in, but not active, I couldn't tell if this was failing to
find the SpeedStep support now or if it simply lost the sysfs interface.

When I compiled in the debug information to the SpeedStep driver, I only
get the following output in dmesg:

cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.70 $


The ACPI P-States driver and the P4 clock modulation driver don't work,
or cause the interface directory to show either, but I have never had
either of those two working before -- I tried them to try and eliminate
a cause.

The content of /sys/devices/sys/cpu0 is:
/sys/devices/sys/cpu0
|-- name
`-- power

0 directories, 2 files

   Daniel

-- 
That's the point of quotations you know; one can use another's words
to be insulting.
        -- Amanda Cross
