Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUBIObv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 09:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbUBIObv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 09:31:51 -0500
Received: from poup.poupinou.org ([195.101.94.96]:24119 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S265227AbUBIObt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 09:31:49 -0500
Date: Mon, 9 Feb 2004 15:31:46 +0100
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
Cc: Georg M?ller <georgmueller@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: cpufreq - less possible freqs with 2.6.2 and P4M
Message-ID: <20040209143146.GA16218@poupinou.org>
References: <402562D4.7010706@gmx.net> <yw1xd68q4h05.fsf@kth.se> <402656CB.7070701@gmx.net> <1076256735.1840.8.camel@LNX.iNES.RO>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076256735.1840.8.camel@LNX.iNES.RO>
User-Agent: Mutt/1.5.4i
From: Bruno Ducrot <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 06:12:15PM +0200, Dumitru Ciobarcianu wrote:
> On Sun, 2004-02-08 at 16:33 +0100, Georg M??ller wrote:
> > M??ns Rullg??rd wrote:
> > > Which cpufreq module are you using?  With p4-clockmod I get lots of
> > > choices, with acpi only the two you mentioned.
> > > 
> > 
> > Ok, that works. With P4 clockmod only there are the freqs I wanted :-)
> 
> But I don't know it's having the effect you desire... :)
> 
> By monitoring /proc/acpi/battery/*/state ("present rate" key) I found
> that by using p4-clockmod at the lovest rate the processor permits, it's
> actually using more energy than by using speedstep_ich (only two levels
> of frequency).
> 
> I don't know if this is a bug of p4-clockmod or a hw bug in my machine
> though... can you please check in your machine?

p4-clockmod offer only the possibility to throtte the cpu (and therefore
you can get a kind of frequency setting when you change the duty cycle),
but it do not scale voltage for the processor, whereas speedstep-ich will
offer you the possibility to scale voltage and frequency by changing
directly the core multiplier.

In fact, if you have at least power control for the processor via ACPI
(look into /proc/acpi/processor/????/power), and your machine support
at least the power state C2, and if you are using the p4-clockmod,
or anything that do throttle the processor, you reduce the windows time
when the processor can enter at least this C2 power state, and this may
actually consume *more* power than you would expect, especially if the
system is mostly idle.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
