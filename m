Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWGRTDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWGRTDR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 15:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWGRTDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 15:03:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:7228 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932362AbWGRTDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 15:03:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LyTGXAGPmHTBLlTViYSFZ9ceuj5LGCBToUxVl8YcBMCqiXPCuD+idwqMwVHx1ldXkDk2PMg3hAV0lHr2EbJKl4okz4/oswOYfUYdoxdKdZj3SXIgm6hO9Koz4LOAMbE3qXup9XjjkF862SrgBk0e+2bUjG0xdPrJ3DjsRRhOweI=
Message-ID: <a762e240607181203q1ceeb1a6k4af348f89da65509@mail.gmail.com>
Date: Tue, 18 Jul 2006 12:03:15 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Andrew Athan" <aathan_linux_kernel_1542@cloakmail.com>
Subject: Re: CPU numbering & hyperthreading
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44BC4200.90308@cloakmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44BC4200.90308@cloakmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/06, Andrew Athan <aathan_linux_kernel_1542@cloakmail.com> wrote:
>
> On an Intel Xeon dual CPU machine running 2.6.16 and up...
>
> I have two highly CPU/memory/network intensive processes with 3-5
> threads each.  I am using sched_setaffinity calls to make sure these two
> processes never compete for the same physical CPU.  Am I right to assume
> that CPU #0 and #1 vs CPU #2 and #3 are separate physical CPUs on a
> 2-CPU w/ hyperthreading box?
>
> I've spent some time looking, but I did not find documentation on
> exactly how CPUs are numbered in a hyperthreaded box.

It is up to the bios how the cpus are layed out.  Any easy way to
check for the info you want is to look at /proc/cpuinfo (you can also
get the info out of /sys/devices/system/cpu/cpu[x]/topology).  Cpus
with the same physical id are in the same package.  The info (core_id
core_siblings  physical_package_id  thread_siblings
and like kind from proc) describes the topology.

Thanks,
  Keith
