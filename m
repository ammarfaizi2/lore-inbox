Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751973AbWKBQoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbWKBQoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 11:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbWKBQoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 11:44:18 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:42719 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751973AbWKBQoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 11:44:17 -0500
Subject: 2.6.19-rc4-mm2 build breakage on ia64
From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: HP/OSLO
Date: Thu, 02 Nov 2006 11:15:23 -0500
Message-Id: <1162484124.5561.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a heads up, as I haven't seen anything on the mailing list.  Build
of '19-rc4-mm2, with the one existing 'acpi-verify-lapic...' hotfix,
breaks on ia64 because generic file drivers/acpi/processor_idle.c
includes <asm/apic.h>.  ia64 uses acpi in which processor_idle.[co] is
not optional, but has no arch specific apic.h [in this tree, anyway].
Looks like it's only needed if ARCH_APICTIMER_STOPS_ON_C3 is defined, so
I've worked around it by creating an empty one.  Maybe not the
appropriate fix.

Lee

