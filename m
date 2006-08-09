Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWHIMgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWHIMgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWHIMgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:36:16 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:2769 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750721AbWHIMgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:36:16 -0400
Date: Wed, 9 Aug 2006 08:35:47 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Pavel Machek <pavel@ucw.cz>
cc: LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net,
       linux-pm@osdl.org, ncunningham@linuxmail.org
Subject: Re: swsusp and suspend2 like to overheat my laptop
In-Reply-To: <20060809120844.GD3747@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0608090831440.3177@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
 <20060808235352.GA4751@elf.ucw.cz> <Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com>
 <20060809073958.GK4886@elf.ucw.cz> <Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0608090751340.2500@gandalf.stny.rr.com> <20060809120844.GD3747@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Aug 2006, Pavel Machek wrote:

>
> Okay, run top to see what goes on, and look for
> /proc/acpi/processor/*/* -- you are interested in C states before and
> after suspend.
> 									Pavel

I don't quite understand.  What am I looking for in top?

Here's the before and after:

before:

$ grep C /proc/acpi/processor/*/*
/proc/acpi/processor/CPU0/power:active state:            C1
/proc/acpi/processor/CPU0/power:max_cstate:              C8
/proc/acpi/processor/CPU0/power:   *C1:                  type[C1]
promotion[--] demotion[--] latency[000] usage[00000000] duration[00000000000000000000]
/proc/acpi/processor/CPU1/power:active state:            C1
/proc/acpi/processor/CPU1/power:max_cstate:              C8
/proc/acpi/processor/CPU1/power:   *C1:                  type[C1]
promotion[--] demotion[--] latency[000] usage[00000000] duration[00000000000000000000]


after:

grep C /proc/acpi/processor/*/*
/proc/acpi/processor/CPU0/power:active state:            C1
/proc/acpi/processor/CPU0/power:max_cstate:              C8
/proc/acpi/processor/CPU0/power:   *C1:                  type[C1]
promotion[--] demotion[--] latency[000] usage[00000000] duration[00000000000000000000]
/proc/acpi/processor/CPU1/power:active
state:            C1
/proc/acpi/processor/CPU1/power:max_cstate:              C8
/proc/acpi/processor/CPU1/power:   *C1:                  type[C1]
promotion[--] demotion[--] latency[000] usage[00000000] duration[00000000000000000000]

-- Steve

