Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWJTQbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWJTQbP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWJTQbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:31:15 -0400
Received: from webserve.ca ([69.90.47.180]:41114 "EHLO computersmith.org")
	by vger.kernel.org with ESMTP id S932271AbWJTQbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:31:13 -0400
Message-ID: <4538F9AD.8000806@wintersgift.com>
Date: Fri, 20 Oct 2006 09:30:37 -0700
From: teunis <teunis@wintersgift.com>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: various laptop nagles - any suggestions?   (note: 2.6.19-rc2-mm1
 but applies to multiple kernels)
References: <4537A25D.6070205@wintersgift.com> <20061019194157.1ed094b9.akpm@osdl.org>
In-Reply-To: <20061019194157.1ed094b9.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
> On Thu, 19 Oct 2006 09:05:49 -0700
> teunis <teunis@wintersgift.com> wrote:
> 
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Setting the internal clock to 100 Hz stablizes the laptop - and the
>> synaptics touchpad stops "crashing"  (when "crashed" the pad reads out
>> all kinds of seemingly random values).   I would suspect the driver
>> needs adjusting for the variable clock.   Also - it's definitely nicer
>> on the laptop power use as far as I can tell - should this be in the
>> documentation?
> 
> So you're saying that CONFIG_NO_HZ breaks the touchpad?

yes.  At least for Acer Travelmate 8000 and HP nx6310 and HP nx7400.
Other than the touchpad - there is not a lot of common hardware between
these units.   The readout becomes highly unreliable.   (in X it starts
jumping around - it SORT OF resembles the output)

My suspicion is a timing problem in the synaptic USB driver - but I'm
not familiar with timing on kernels these days.  It's been a few years
since I last really did any kernel work.

> 
>> I'm very grateful that compact flash-based booting on a SATA system
>> works well.   It hasn't been so reliable in 2.6.19-rc2-mm1 for IDE/CF
>> adaptors but I haven't yet solved why.   (tested with various laptops)
> 
> hm.  What goes wrong?

Fails to boot some of the time on SanDisk ultraII 8.0GB and SanDisk
Extreme IV 8.0GB.   The latter is less stable.   It crashes during GRUB
read actually so I haven't been entirely sure it's a kernel problem...

> 
>> resume from "suspend to ram" (ACPI S3 mode) - the keyboard and mouse do
>> not recover on 945G chipset.   Note that otherwise the chipset works
>> well in 2.6.19-rc2-mm1 - and this is the first kernel that does work well).
> 
> So this might not be a new bug?

A regression.   2.6.19-rc1-git6 seemed to work actually.   I couldn't
get any other kernel to work though...   mind you, 2.6.18 worked as well
although the intel 945G driver did not - so X was operating under VESA only.

>> LVM2 - when adding and removing physical volumes (again, on Compact
>> Flash cards via USB and Firewire adaptors) - it doesn't always remove
>> the volume properly (pvremove /dev/sda or equiv) from the device-mapper.
>>  This leaves me unable to plug in another.   I suspect this to be an
>> LVM2 problem (no hotplug?) rather than a compact flash or SCSI problem.
> 
> Can you identify an earlier kernel in which this worked OK?

As far as I can it never has.

I've only tested it with:
2.6.16-debian, 2.6.17-debian, 2.6.18, 2.6.19, 2.6.19-rc1,
2.6.19-rc1-git4, 2.6.19-rc1-git6, 2.6.19-rc2, 2.6.19-rc2-mm1 (which
otherwise works quite nicely)

Thank you!
	- Teunis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOPmhbFT/SAfwLKMRAgtIAKCViVmBluTbdpRSYMxzYdEo5Qd7OQCgrhOJ
jtsnxbRGSlvSJB/WkYbrWrI=
=WG3a
-----END PGP SIGNATURE-----
