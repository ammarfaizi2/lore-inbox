Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVCCO45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVCCO45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 09:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVCCO45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 09:56:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55722 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261790AbVCCO4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 09:56:39 -0500
Date: Thu, 3 Mar 2005 15:55:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-pm@osdl.org
Subject: Re: [linux-pm] [PATCH] Custom power states for non-ACPI systems
Message-ID: <20050303145522.GA3485@openzaurus.ucw.cz>
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com> <20050302085619.GA1364@elf.ucw.cz> <42263719.7030004@mvista.com> <20050302221150.GE1616@elf.ucw.cz> <422659B1.9090608@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422659B1.9090608@mvista.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >...but adding new /sys/power/state might be okay. We should not have
> >introduced "standby" in the first place [but I guess it is not worth
> >removing now]. If something has more than 2 states (does user really
> >want to enter different states in different usage?), I guess we can
> >add something like "deepmem" or whatever. Is there something with 
> >more
> >than 3 states?
> 
> In most of the cases I'm thinking of, it wouldn't be a user 
> requesting a state but rather software (say, a cell phone 
> progressively entering lower power states due to inactivity).  I 
> haven't noticed a platform with more than 3 low-power modes so far, 

Are not your power states more like cpu power states?
These are expected to be system states, and sleeping system
does not take calls, etc...

(Unless you have second cpu that wakes you on incoming call, that is).

> but I'm sure it'll happen soon. If the time isn't right for 
>  incompatible changes to these interfaces then I guess mapping standby 
> and mem to platform-specific things will work for now, maybe with 
> some tweak to allow a choice of actual state entered.  At some more 
> opportune time in the future I'll suggest an attribute that allows a 
> choice of platform-specific method of suspend-to-mem, somewhat like 
> the "disk" attribute for suspend-to-disk. 
Or just resurrect your original patch when one more state is needed.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

