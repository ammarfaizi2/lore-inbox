Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265733AbSKAUP2>; Fri, 1 Nov 2002 15:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265734AbSKAUP2>; Fri, 1 Nov 2002 15:15:28 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:60959 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265733AbSKAUP1>; Fri, 1 Nov 2002 15:15:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Dave Jones <davej@codemonkey.org.uk>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: 2.5.45 build failed with ACPI turned on
Date: Fri, 1 Nov 2002 22:21:56 +0100
User-Agent: KMail/1.4.3
Cc: Robert Varga <nite@hq.alert.sk>, linux-kernel@vger.kernel.org
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A498@orsmsx119.jf.intel.com> <20021101194711.GB714@suse.de>
In-Reply-To: <20021101194711.GB714@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211012221.56346.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 November 2002 20:47, Dave Jones wrote:
> On Fri, Nov 01, 2002 at 11:37:26AM -0800, Grover, Andrew wrote:
>  > ACPI implements PM but that's not all it implements. Is making CONFIG_PM
>  > true if ACPI or APM are on a viable option? I think that would more
>  > accurately reflect reality.
>  >
>  > Or can we get rid of CONFIG_PM?
>
> I'm not sure of places that do it off the top of my head, but
> CONFIG_PM would save us having to do ugly CONFIG_APM || CONFIG_ACPI
> tests.

This seems to be true from what I have seen of the source so far.

I'm thinking....

ACPI is more than Power Management. The fact that a system supports ACPI does 
not mean that the user wants to use power management. On the other hand, I 
see no reason why a user does NOT want a system to auto poweroff, and sleep 
and suspend are easy to configure in BIOS, or by linux tools. (Does Linux 
take over the BIOS settings for suspend & sleep ? Don't use them, so 
donnow....) What I wanna say: I think it is okay if CONFIG_PM is replaced by 
CONFIG_APM || CONFIG_ACPI

Other issue: Are ACPI and APM not mutually exclusive ? If so, I would propose 
a selection box: <ACPI> <APM> <none> with related options shown below. Hmzz.. 
there the issue of the fact that ACPI is more than power management shows up 
again.

And well... CONFIG_APM || CONFIG_ACPI might look ugly to you, I think it isn't 
that bad, besides, you gain a lot from the configuration side. IMHO 
configuring the kernel has become hard enough with the new input layer 
already :( Maybe it is time for a "[ ] show expert options" in the 
configuration tool... 

Jos

