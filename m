Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRB1Uqm>; Wed, 28 Feb 2001 15:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129271AbRB1Uqc>; Wed, 28 Feb 2001 15:46:32 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:47116 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S129111AbRB1UqX>; Wed, 28 Feb 2001 15:46:23 -0500
Date: Wed, 28 Feb 2001 13:46:20 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 kernels - "attempt to access beyond end of device"
Message-ID: <20010228134620.A29971@mail.harddata.com>
In-Reply-To: <20010226191007.A15716@mail.harddata.com> <20010227163627.A23026@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
In-Reply-To: <20010227163627.A23026@mail.harddata.com>; from Michal Jaegermann on Tue, Feb 27, 2001 at 04:36:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that I found what gives me a hell with this box and it
looks like that this not Linux at all.  Once again, this is Athlon
K6 on Asus AV7 mobo and "Award Advanced ACPI BIOS" version 1005C.
I have more checks to make before I will be fully satisfied but
this looks like it.

In this BIOS setup there are two "advanced" options:

System Performance Setting [Optimal, Normal]
USB Legacy Support [Auto, Enabled, Disabled]

If the first one is set to "Normal" and the second one to "Disabled"
then the whole system becomes stable.  I copied from various file
systems to a directory+on ext2 around 1.2 GB of files without any ill
effects and run succesfully 'diff -r' between two directories 475 MB 
each.  If BIOS options are any other way then one should expect
spectacular blowups with corrupted file systems and other nasty effects
after the first oops.  It survives up to something between 130 to 150
MB of data moved, does not matter which kernel, and that is it.

It is difficult to know what is "System Performance Setting" as it
always shows "Optimal" regardless of a status on the last save.  But a
system behaviour depends on how it was set so it seems to change even if
a display, on the next visit, does not.  How "USB Legacy Support" comes
into the picture I cannot even imagine.

I did try with 2.2.19pre and 2.4 kernels and the picture does not
change.  Any rational explanation beyond that BIOS is doing something
really nasty?

  Cheers,
  Michal

