Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbRFFUmc>; Wed, 6 Jun 2001 16:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbRFFUmY>; Wed, 6 Jun 2001 16:42:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14088 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261274AbRFFUmI>; Wed, 6 Jun 2001 16:42:08 -0400
Date: Wed, 6 Jun 2001 22:42:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Chris Boot <bootc@worldnet.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
Message-ID: <20010606224203.A2044@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010606155026.A28950@bug.ucw.cz> <B74421C0.F6F7%bootc@worldnet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <B74421C0.F6F7%bootc@worldnet.fr>; from bootc@worldnet.fr on Wed, Jun 06, 2001 at 06:06:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Please, don't.
> > 
> > Use kelvins *0.1, and use them consistently everywhere. This is what
> > ACPI does, and it is probably right.
> 
> I'm sorry, by I don't feel like adding 273 to every number I get just to
> find the temperature of something.  What I would do is give configuration
> options to choose the default (Celsius/centigrade, Kelvin, or [shudder]
> Fahrenheit) then, when you need to print or output a temperature, send it
> off to a common converter function so you don't repeat core all over the
> place.

No. Sorry. Create nice tool to display info for you. We are talking
about output from kernel. It *must not* be configurable. Or do you
want your programs to read 58 from /proc/acpi/thermal/1/status and
then reading /proc/units to see if it is celsius or farenhait.

ACPI is already using 0.1*K, so everything should use that to be
consistent.
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
