Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271399AbTG2LHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271400AbTG2LHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:07:09 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:43967 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S271399AbTG2LHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:07:05 -0400
Date: Tue, 29 Jul 2003 13:07:02 +0200 (MEST)
Message-Id: <200307291107.h6TB72iP027715@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, wturkal@cbu.edu
Subject: RE: PROBLEM: ACPI hangs when invoked from keyboard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003 01:06:08 -0500, Warren Turkal wrote:
>Grover, Andrew wrote:
>> This isn't ACPI, it's because 2.5.74+ force the APIC enabled.
>
>You are correct, and here is my addition to this bug report.
...
>At this point, I relized that I had been compiling these
>kerenels without SMP, which is not what I did when I
>noticed the bug. Therefor, it is an SMP-kernel-only bug.
>I have a 1.9GHz Pentium 4M. My understanding is that it
...
>Therefore, the breaking patch is the changeset from svn
>revion 11314 to 11315, which is reproduced below,
>including the patch comment.
>
>patch comment:
>wt@braindead:/usr/src/linux-trunk$ svn log -r 11315
>------------------------------------------------------------------------
>rev 11315:  mikpe | 2003-06-24 14:50:23 -0500 (Tue, 24 Jun 2003) | 17 lines
>
>[PATCH] enable local APIC on P4
...
>Either there is a bug with supporting my type of APIC or my APIC
>must have a bug and is disabled by the BIOS for a reason. Either
>my hardware should be blacklisted or the old behavior should be
>restored.
>
>AFAIK, I have an Intel 845 chipset. I don't know what other info
>is needed for blacklisting.

The bug is not in the hardware but in the BIOS code.
I'm planning a patch to revert P4s to a safe default, it'll
be posted on LKML shortly.

Out of curiosity, what make & model is your laptop?

/Mikael
