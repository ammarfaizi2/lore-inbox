Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTITKIe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 06:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTITKIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 06:08:34 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:35774 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261807AbTITKId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 06:08:33 -0400
Date: Sat, 20 Sep 2003 12:08:23 +0200 (MEST)
Message-Id: <200309201008.h8KA8NAR029813@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: jwendel10@comcast.net, wli@holomorphy.com
Subject: Re: [ATTN IBM Guys] NMI count on X440 box
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Sep 2003 19:34:15 -0700, William Lee Irwin III wrote:
>On Fri, Sep 19, 2003 at 07:31:03PM -0700, John Wendel wrote:
>> I just noticed that our 8-way X440 is showing (in /proc/interrupts)
>> about 100 NMIs / second, on each CPU. Would some kind soul please tell
>> me if this is OK? A brief explanation of what this interrupt is being
>> used for would be appreciated.
>> We're running the latest RH Advanced server kernel.
>> </curious>
>> Sorry if this is a stupid question.
>
>A common use for intentional NMI's is NMI-based profiling, i.e. oprofile.
>I can't say for sure this is where your NMI's are coming from without
>seeing more about your kernel.

This case is more likely to be the NMI watchdog.
Having it enabled is normal and good, but you can disable it
by booting without the nmi_watchdog= parameter.
