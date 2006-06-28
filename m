Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423200AbWF1HyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423200AbWF1HyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWF1HyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:54:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:17623 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030468AbWF1HyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:54:03 -0400
Message-ID: <44A23598.4020108@suse.de>
Date: Wed, 28 Jun 2006 09:54:00 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Gerd Hoffmann <kraxel@suse.de>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] x86_64: x86_64 version of the smp alternative patch.
References: <200606261900.k5QJ0k9J028243@hera.kernel.org> <20060627175741.GF1280@redhat.com>
In-Reply-To: <20060627175741.GF1280@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This has one behaviour slightly different to the i386 version however.
> If you boot an SMP machine it does this..
> 
> SMP: Allowing 4 CPUs, 2 hotplug CPUs
> Initializing CPU#0
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 0
> CPU0: Thermal monitoring enabled (TM1)
> SMP alternatives: switching to UP code
> ..
> SMP alternatives: switching to SMP code
> Booting processor 1/2 APIC 0x1
> Initializing CPU#1

i386 shows the same behavior btw, but with CPU_HOTPLUG=y only.  "booting
the second CPU" is just a special case of "plugging in a CPU" then, that
is where the double-switch comes from.

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg
