Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVCaOpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVCaOpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVCaOpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:45:19 -0500
Received: from sd291.sivit.org ([194.146.225.122]:35080 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261473AbVCaOpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:45:12 -0500
Date: Thu, 31 Mar 2005 16:45:11 +0200
From: Stelian Pop <stelian@popies.net>
To: Philip Lawatsch <philip@lawatsch.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64 Machine hardlocks when using memset
Message-ID: <20050331144510.GB12314@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Philip Lawatsch <philip@lawatsch.at>, linux-kernel@vger.kernel.org
References: <424B228B.8000807@lawatsch.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424B228B.8000807@lawatsch.at>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 12:04:59AM +0200, Philip Lawatsch wrote:

> I do have a very strange problem:
> 
> If I memset a ~1meg buffer some thousand times (in the userspace) it
> will hardlock my machine.
> 
> I've been using 2.6.12-rc1 and also a lot of other kernels (2.6.9,
> 2.6.11). I've tried it both using a 32 bit kernel and a 64 bit kernel.
> When running on the 32 bit kernel the machine hardlocks after about
> 15000 iterations, on a 64 bit kernel the machine hardlocks after about
> 5000 (the 64 bit system has nearly no background jobs running).
> 
> I've been running memcheck for several hours now but nothing did show up.
> 
> 
> I've got an Asus A8N-SLI board with 2 gigs of memory and an AMD 3500+ CPU.
> 
> The 64 bit kernel was compiled using gcc 3.4.3 and the 32 bit kernel
> using 3.3.5.
[...]

> powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
> powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x6 (1400 mV)
> powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x8 (1350 mV)
> powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
> powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
> cpu_init done, current fid 0xe, vid 0x6

Just a thought: does deactivating cpufreq change anything ?

I haven't tested yet your program, but on my Asus K8NE-Deluxe very
strange things happen if cpufreq/powernow is activated *and* 
the cpu frequency is changed...

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
