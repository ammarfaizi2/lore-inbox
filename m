Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318649AbSGZXjY>; Fri, 26 Jul 2002 19:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318648AbSGZXjY>; Fri, 26 Jul 2002 19:39:24 -0400
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:5381 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id <S318649AbSGZXjX>;
	Fri, 26 Jul 2002 19:39:23 -0400
Subject: Re: [PATCH] fix APM notify of apmd for on-AC/on-battery transitions
From: Ray Lee <ray-lk@madrabbit.org>
To: cort@fsmlabs.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 26 Jul 2002 16:42:28 -0700
Message-Id: <1027726949.2691.68.camel@orca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there Cort,

It looks like my Vaio will need it as well -- loading the apm module
with debug=1 doesn't show any on/off battery events when I yank the
power. (It does log other events, though.)

A comment on the patch? How about pushing the specifics of the
apm_bios_power_change_bug from check_events() down into either the
get_event() or apm_get_event() routines? That way the specifics are
abstracted a bit from the main event dispatch loop, and one gets to
inherit the debug logging and whatnot.

And, in case you decide to tighten up the dmi matching, my laptop info
follows:

	BIOS Information Block
		Vendor: Phoenix Technologies LTD
		Version: R0117A0
		Release: 04/25/00
	System Information Block
		Vendor: Sony Corporation    
		Product: PCG-XG29(UC)        

Thanks,

Ray



