Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTKOSg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 13:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTKOSg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 13:36:59 -0500
Received: from [200.57.38.4] ([200.57.38.4]:5315 "EHLO gateway.mailvault.com")
	by vger.kernel.org with ESMTP id S261890AbTKOSg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 13:36:57 -0500
Date: Sat, 15 Nov 2003 19:36:52 00100 (CET)
To: Mark Hahn <hahn@physics.mcmaster.ca>
From: "Job 317" <job317@mailvault.com>
Subject: Re: 2.4.22 SMP kernel build for hyper threading P4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary = "=_d08afc3bf0a478b35f08c90cc29f30a7"
Message-Id: <20031115183625.1BAA7840597@gateway.mailvault.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encoded message.

--=_d08afc3bf0a478b35f08c90cc29f30a7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On 15-Nov-2003 17:30:11 +0100, you wrote:
> > I have a new P4 Hyperthreading PC that I have installed RedHat9 on.
I am
> 
> I presume you realize that anyone who understands HT has mostly scorn
for it.

I had no idea but it is still a huge improvement over my HP 755MHz
Celleron that I am replacing ;) Might I as why so and am I wasting my
time when a non-SMP kernel builds and works just fine?

> 
> > api, etc.) but when I build my new 2.4.22 kernel with CONFIG_SMP=y
set
> > then reboot, I am seeing only one processor in /proc/cpuinfo. When
I
> > boot with my stock RH9 2.4.20-20.9smp kernel I see two virtual
> > processors show up in /proc/cpuinfo.
> 
> I'm guessing you don't have acpi enabled.

Hmm... Let's have a look. I started by loading the
kernel-2.4.20-i686-smp.config file that came with the RH9 distro into
xconfig. I just turned on ntfs and a couple of other things and saved.
The comparision is strange. My new config file has:

# CONFIG_ACPI is not set

however the RH9 config file has:

# CONFIG_ACPI is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_ACPI_HT_ONLY is not s
CONFIG_ACPI_BUSMGR=m
CONFIG_ACPI_SYS=m
CONFIG_ACPI_CPU=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_AC=m
CONFIG_ACPI_EC=m
CONFIG_ACPI_CMBATT=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_RELAXED_AML=y

So should I have all this or no?

> 
> > I've even build a 2.4.22 kernel with the config-2.4.20-20.9smp
> > configuration that came with RH9.
> 
> RH doesn't ship kernel.org sources, of course.  hence the -20.

Rgr. I got this.

> 
> > I build with the straightforward 'make dep clean bzImage modules
> > modules_install' command. Is this correct?
> 
> sure.  obviously, you need to verify that you're booting the kernel
> that you just made, etc.

It does boot and everything else "seems" fine. Just that I still only
get one virtual CPU showing up in /proc/cpuinfo.

> 
> > Am I missing a step to build a smp kernel for hyper threading?
> 
> HT is a non-feature; it requires nothing from the kernel.  I'm
> guessing your problem is bios or acpi.
> 

I still don't understand. So am I wasting my time with HT?

Thanks,

Job
--=_d08afc3bf0a478b35f08c90cc29f30a7--


