Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbTEMG65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTEMG65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:58:57 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:22107 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S263272AbTEMG6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:58:53 -0400
From: Jos Hulzink <josh@stack.nl>
To: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: [RFC] How to fix MPS 1.4 + ACPI behaviour ?
Date: Tue, 13 May 2003 09:15:58 +0200
User-Agent: KMail/1.5
References: <200305122135.53751.josh@stack.nl> <20030513050133.GA4720@middle.of.nowhere>
In-Reply-To: <20030513050133.GA4720@middle.of.nowhere>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305130915.58419.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 May 2003 07:01, Jurriaan wrote:
> Is this with or without IOAPIC? I got some problems with MPS 1.4, acpi
> and the local ioapic on a uniprocessor system, see bugzilla 678. I think
> it's a different problem, though.

Your problem looks the same, though isn't, for your kernel finds a MADT:

ACPI: RSDP (v000 KT400                      ) @ 0x000f74a0
ACPI: RSDT (v001 KT400  AWRDACPI 16944.11825) @ 0x3fff3000
ACPI: FADT (v001 KT400  AWRDACPI 16944.11825) @ 0x3fff3040
vvvvv
ACPI: MADT (v001 KT400  AWRDACPI 16944.11825) @ 0x3fff71c0
^^^^^
ACPI: DSDT (v001 KT400  AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist

And ACPI uses the IOAPIC, as expected:

ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing

Unfortunately, we're talking two different bugs :(

Jos
