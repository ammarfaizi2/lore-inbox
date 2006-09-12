Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWILLGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWILLGH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 07:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWILLGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 07:06:07 -0400
Received: from hermes.domdv.de ([193.102.202.1]:44043 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S932254AbWILLGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 07:06:04 -0400
Message-ID: <45069494.8070904@domdv.de>
Date: Tue, 12 Sep 2006 13:05:56 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       Eric Sandall <eric@sandall.us>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Suspend to ram with 2.6 kernels
References: <44FF8586.8090800@sandall.us> <20060907193333.GI8793@ucw.cz> <450536D0.4020705@domdv.de> <200609112227.15572.rjw@sisk.pl> <4505E304.7000302@domdv.de> <20060911235920.GA24597@srcf.ucam.org>
In-Reply-To: <20060911235920.GA24597@srcf.ucam.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Tue, Sep 12, 2006 at 12:28:20AM +0200, Andreas Steinmetz wrote:
> 
> 
>>Nope,
>>but the hint from this thread was good: s2ram works with
>>"acpi_skip_timer_override" and probably "enable_timer_pin_1" (I have to
>>try without this one, yet). Radeon, however, remains as a problem.
> 
> 
> Can you test with the following patch (without 
> acpi_skip_timer_override)?
> 

Yes, the patch fixes s2ram without acpi_skip_timer_override for me (x86_64).

There is, however, one difference during boot that may be a hint:
When booting without acpi_skip_timer_override the following message appears:

MP-BIOS bug: 8254 timer not connected to IO-APIC

As a sidenote booting without enable_timer_pin_1 doesn't make any
difference as expected.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
