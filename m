Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVIGQ2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVIGQ2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVIGQ2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:28:03 -0400
Received: from fmr23.intel.com ([143.183.121.15]:39074 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750966AbVIGQ2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:28:01 -0400
Date: Wed, 7 Sep 2005 09:27:16 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 09/14] x86_64: Don't call enforce_max_cpus when hotplug is enabled
Message-ID: <20050907092715.A31884@unix-os.sc.intel.com>
References: <200509032135.j83LZ5Od020541@shell0.pdx.osdl.net> <20050905044821.GH17516@muc.de> <20050906155617.A19439@unix-os.sc.intel.com> <20050907064950.GB96684@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050907064950.GB96684@muc.de>; from ak@muc.de on Wed, Sep 07, 2005 at 08:49:50AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 08:49:50AM +0200, Andi Kleen wrote:
> > 
> > You had suggested in that discussion that it would be better to add an 
> > option for startup. Iam opposed to adding any option, when we certainly know 
> 
> I suggested to auto detect it based on ACPI information. I don't 
> think I ever wrote anything about an option.
> 
> If that is not possible it's better to always use the sequence mechanism.

Using ACPI or any other method to choose broadcast or use mask version
of IPI in flat mode for <=8 cpus has no real value. I had posted a 
small stat program that showed using mask IPI provides same performance numbers.

We didnt choose that method only because there is no perf gain except code 
bloat. I dont understand putting all that complexity without any real merrit.

Moreover CONFIG_HOTPLUG_CPU does not imply physical CPU hotplug, which i had
tried to convey several times. 

It is important to understand that there is no just ONE RIGHT way
and that we consider alternatives for the right reason.

> 
> 
> P.S.: Don't bother sending me such "blame game" mails again. I will
> just d them next time because they're a waste of time.

Sorry Andi if you felt that way. I was trying to get some consistent feedback
and that you also consider and weight in what we explain instead of being
a one way street.

Certainly my intend was not to blame you, but to explain with clarity
so we dont end up reworking some trivial patches for a long time.

If you feel that way, i deeply apologize, and repeat, thats not my intend.
> 

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
