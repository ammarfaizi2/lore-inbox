Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSBXMBl>; Sun, 24 Feb 2002 07:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286339AbSBXMBb>; Sun, 24 Feb 2002 07:01:31 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:32215 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S286322AbSBXMB0>;
	Sun, 24 Feb 2002 07:01:26 -0500
Date: Sun, 24 Feb 2002 13:01:23 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200202241201.NAA11762@harpo.it.uu.se>
To: beh@icemark.net
Subject: Re: Some problems on a ThinkPad A30P (again...)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2002 23:53:53 +0100 (CET), beh@icemark.net wrote:
> -> Hibernation doesn't work at all (this used to work on the TP600
>    and on the TP A21P I had before)...
> -> When the system resumes from a suspend, the following message
>    turns up in dmesg:
>
>	APIC error on CPU0: 00(40)

This indicates that your A30P has a local-APIC capable P6-class
cpu, and that you're not using the latest 2.4.18-pre or -rc kernel.

The APIC error at resume from suspend is fixed in current 2.4.18-rc,
so a simple kernel upgrade will silence that message.

Your machine survives APM suspend? That's encouraging since I've
had a report that the T20 doesn't if the local APIC is enabled.
What's the difference between suspend and hibernate?
Does the machine survive if you pull the power cord or enter the
BIOS setup screens?

/Mikael
