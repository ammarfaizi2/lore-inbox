Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264508AbTK0MSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 07:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTK0MSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 07:18:14 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:13197 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S264508AbTK0MSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 07:18:13 -0500
Date: Thu, 27 Nov 2003 13:18:01 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Simon <simon@highlyillogical.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test10] cpufreq: 2G P4M won't go above 1.2G - cpuinfo_max_freq too low
Message-ID: <20031127121801.GB9098@localhost>
References: <200311271139.07260.simon@highlyillogical.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200311271139.07260.simon@highlyillogical.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 27th 2003 Simon wrote:

> I have a P4 2ghz (in a thinkpad), but it's not running at over about 1.2ghz 
> now. If I `cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq` it 
> tells me: "1198976". It should go faster than that. Similarly, 
> scaling_available_frequencies says "149872 299744 449616 599488 749360 899232 
> 1049104 1198976"

Don't know if this will help you, but I had the exact same problem on a
Compaq EVO N1050v (well 1.8 GHz instead of 2.0 GHz and it initially only
managed 1.2 GHz as mentioned in /proc/cpuinfo and from benchmarks).

It turned out to be an ACPI problem. Booting on 2.6 with "acpi=off" lead
to the correct 1.8GHz determination instead of only 1.2GHz, but no working
ACPI of course. On 2.4.21 booting either with of without ACPI made no
difference and lead on both occasions to 1.8GHz.

After upgrading the BIOS to the latest version I could finally run 2.6
with ACPI and at full capacity.

Incidentally a certain other OS which shall remain unnamed, reported the
maximum speed also as 1.2 GHz before the BIOS upgrade and as 1.8 GHz
after, but worked both times at 1.8 GHz, just as in Linux 2.4 ;-) After
this final hurdle had been straddled I regained control of /dev/hda1;
Anton does great work on NTFS, but I have work to do!
-- 
Marco Roeland
