Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbTFRIND (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 04:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbTFRINC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 04:13:02 -0400
Received: from h-64-105-35-33.SNVACAID.covad.net ([64.105.35.33]:11648 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S265089AbTFRINB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 04:13:01 -0400
Date: Wed, 18 Jun 2003 01:27:55 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200306180827.h5I8Rtl27217@freya.yggdrasil.com>
To: ak@suse.de
Subject: 2.5.72 x86-generic missing enable_apic_mode()
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	x86-generic in 2.5.72 does not compile, because
include/asm-i386/mach-generic/mach_apic.h does not define
enable_apic_mode().  Although I kludged around this, by
just defining enable_apic_mode() as nothing (since it is
apparently nothing for all x86 platforms except es7000),
I imagine that the correct definition is

#define enable_apic_mode (genapic->enable_apic_mode)

	...along with some other changes to declare
genapic->enable_apic_mode and initialize it for each platform
type.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
