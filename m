Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbTEaKjn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 06:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbTEaKjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 06:39:43 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:8082 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264269AbTEaKjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 06:39:41 -0400
Date: Sat, 31 May 2003 12:52:59 +0200 (MEST)
Message-Id: <200305311052.h4VAqxEM001927@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: rol@as2917.net
Subject: Re: [2.5.70] - APIC error on CPU0: 00(40)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003 11:16:18 +0200, Paul Rolland wrote:
>After booting, I found the following messages :
>
>APIC error on CPU0: 00(40)
>APIC error on CPU0: 40(40)
>last message repeated 5 times
>
>at boot time...
>
>The dmesg output is just below. The machine is a P4 2.4GHz, on an
>Asus P4S8X mobo.
>
>What is it ? Can I safely ignore them ?
>
>I also have a very strange :
>USB scanner device (0x03f0/0x2005) now attached to ^ER^VÀ\2003¸ß\200 ¸ß\2003¸ß<7OÀØ6OÀÀ6OÀ

Received illegal vector errors. Your boot log reveals that you're
using ACPI and IO-APIC on a SiS chipset. Disable those and try
again -- I wouldn't bet on ACPI+IO-APIC working on SiS.

/Mikael
