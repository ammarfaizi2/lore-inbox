Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVCCAtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVCCAtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVCCA1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:27:43 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:13052 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261205AbVCCA02
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:26:28 -0500
Message-ID: <422659B1.9090608@mvista.com>
Date: Wed, 02 Mar 2005 16:26:25 -0800
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: Re: [linux-pm] [PATCH] Custom power states for non-ACPI systems
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com> <20050302085619.GA1364@elf.ucw.cz> <42263719.7030004@mvista.com> <20050302221150.GE1616@elf.ucw.cz>
In-Reply-To: <20050302221150.GE1616@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
...
> ...but adding new /sys/power/state might be okay. We should not have
> introduced "standby" in the first place [but I guess it is not worth
> removing now]. If something has more than 2 states (does user really
> want to enter different states in different usage?), I guess we can
> add something like "deepmem" or whatever. Is there something with more
> than 3 states?

In most of the cases I'm thinking of, it wouldn't be a user requesting a 
state but rather software (say, a cell phone progressively entering 
lower power states due to inactivity).  I haven't noticed a platform 
with more than 3 low-power modes so far, but I'm sure it'll happen soon. 
  If the time isn't right for incompatible changes to these interfaces 
then I guess mapping standby and mem to platform-specific things will 
work for now, maybe with some tweak to allow a choice of actual state 
entered.  At some more opportune time in the future I'll suggest an 
attribute that allows a choice of platform-specific method of 
suspend-to-mem, somewhat like the "disk" attribute for suspend-to-disk. 
  Thanks,

-- 
Todd
