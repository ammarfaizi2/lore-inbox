Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTJORwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTJORwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:52:17 -0400
Received: from auemail2.lucent.com ([192.11.223.163]:48036 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263834AbTJORvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:51:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16269.34470.987994.870487@gargle.gargle.HOWL>
Date: Wed, 15 Oct 2003 13:40:54 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Peter Maersk-Moller <peter@maersk-moller.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx lockup for SMP for 2.4.22
In-Reply-To: <3F8D3A47.1000804@maersk-moller.net>
References: <3F8D1377.3060509@maersk-moller.net>
	<3F8D3A47.1000804@maersk-moller.net>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Peter> More info on the subject. It turns out that a 2.4.22 kernel
Peter> without SMP-support but with IO-APIC enabled will also
Peter> lock-up/stop when it installs the aic7xxx driver upon
Peter> boot. Disabling the IO-APIC and disabling SMP-support makes the
Peter> kernel boot normally.

Peter> Peter Maersk-Moller wrote:
>> Hi
>> Recent postings on this suggest some changes/problems with
>> aic7xxx, but none of them seems to be like this.
>> It seems that the aic7xxx driver while booting a SMP enabled
>> 2.4.22 kernel waits (lock-up?) forever.
>> The lock-up does not happen if I disable SMP, make distclean
>> and recompile the kernel.
>> The controller used is a PCI based Adaptec 29160 (aic7892).
>> The board is a dual Pentium III DBD100 from Iwill.
>> Compiler GCC 3.2.3
>> Distro : Slackware 9.1
>> Has anyone else seen this ?

I've got a 2.4.21 system running SMP, PIII Xeon, booting off AIC7890,
using AIC7880, and another 2940 (I think) along with a pair of 120gb
drives on the IDE controllers.  It's working quite nicely, and I'm
planning on moving to 2.4.22 soon as well.

My system has the Intel GX chipset, what does yours have?  I've also
turned off ACPI in the bios, but I do have:

  CONFIG_X86_IO_APIC=y
  CONFIG_X86_LOCAL_APIC=y
  CONFIG_X86_GOOD_APIC=y

in my config.  Maybe it's a chipset issue you're seeing?

John
