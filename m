Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVDFMrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVDFMrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVDFMq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:46:59 -0400
Received: from gizmo03ps.bigpond.com ([144.140.71.13]:16100 "HELO
	gizmo03ps.bigpond.com") by vger.kernel.org with SMTP
	id S262135AbVDFMqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 08:46:53 -0400
Message-ID: <4253DA3A.5040703@bigpond.net.au>
Date: Wed, 06 Apr 2005 22:46:50 +1000
From: Doug Gray <dgra1233@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Hyperthreading on dual Xeon VME board]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

How can I get Hyperthreading working on my dual Xeon board when the BIOS does not contain the ACPI
support module?

Is there a magic set of kernel options that will get the kernel to start the Hyperthreaded CPUs?

Background:

I am having a problem with a dual (physical) Xeon VME single board (from GMS model V269)) getting
hyperthreading up and going on the CPUs.  Two physical CPUs are recognised but not the

I have Fedora Core 3 installed with the SMP kernel now upgraded (rpm) to 2.6.10

The board manufacturer has not included the ACPI module in the BIOS (AMIBIOS8) for their own
reasons.  GMS position is that this is only a power management function and users of this board
would not require power manangement.

The BIOS Northbridge (Serverworks GC-LE) support does have a switch option to enable hyperthreading,
this is enabled.

As I understand ACPI the BIOS passes configuration information about the CPUs to the Linux Kernel
which then know how to initialise the Hyperthreading CPUs.

Apparently Windows does not require this information from the Kernel to run Hyperthreading so
naturally GMS (the board manufacturer) is not willing to spend the effort to get ht on Linux sorted out.

On booting the Linux dmesg shows the message "ACPI: Unable to locate RSDP"  which I interpret to
mean the Kernel is unable to find the resource information table which should have been setup by the
BIOS.

I have tried the kernel parameter acpi=ht but this did nothing to activate the ht activity.

Does this make sense?
Hoping someone can give me some clues.
Doug


