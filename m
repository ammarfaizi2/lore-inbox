Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWC3NSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWC3NSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWC3NSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:18:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58029 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932201AbWC3NSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:18:08 -0500
Date: Thu, 30 Mar 2006 15:17:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
Message-ID: <20060330131726.GV8485@elf.ucw.cz>
References: <20060329220808.GA1716@elf.ucw.cz> <20060329144746.358a6b4e.akpm@osdl.org> <20060329150950.A12482@unix-os.sc.intel.com> <20060329192453.538a131d.akpm@osdl.org> <20060330050005.A19403@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330050005.A19403@unix-os.sc.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> here is an attempt to explain why...
> 
> > 
> > Something which remains to be beaten into my head: *why* does HOTPLUG_CPU
> > require flat pyhsical mode?  What necessitated that change, and cannot we
> > make it work OK in logical mode as well as flat mode?
> 
> Short answer
> 
> 1. Will hotplug work today in logical flat mode without selecting bigsmp?
> 
>    	Yes, since we avoid broadcast on i386 IPI's with no_broadcast option.
> 
> 2. Why use bigsmp then?
>    There is no reason to do the same thing in two different ways. i.e using
>    logical flat with no_broadcast=1, or use the bigsmp by default when hotplug cpu is
>    enabled. IOW we wanted the handling consistent with what we do for x86_64, hence the 
>    decision to use bigsmp automatically when hotplug is enabled or
> we notice >8 CPUS.

Why not make it even more consistent and just use bigsmp mode by
default, even for X86_PC? X86_BIGSMP would be reduntant, then...
									Pavel

-- 
Picture of sleeping (Linux) penguin wanted...
