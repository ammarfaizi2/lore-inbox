Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUANCtv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 21:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbUANCtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 21:49:51 -0500
Received: from amdext2.amd.com ([163.181.251.1]:39893 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S265944AbUANCtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 21:49:49 -0500
Message-ID: <99F2150714F93F448942F9A9F112634C080EF398@txexmtae.amd.com>
From: paul.devriendt@amd.com
To: pavel@ucw.cz
cc: davej@redhat.com, cpufreq@www.linux.org.uk, linux@brodo.de,
       linux-kernel@vger.kernel.org, mark.langsdorf@amd.com
Subject: RE: Cleanups for powernow-k8
Date: Tue, 13 Jan 2004 20:49:28 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 6C1A71B313206812-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd suggest to leave old driver there (possibly let me clean it up
> ;-)))), and create new powernow-k8-acpi, or powernow-acpi or something
> like that.
> 								Pavel

Keeping the old driver around for machines without ACPI support or with
broken ACPI support sounds reasonable to me. Please feel free to clean
it up. Feel free to send it to me if you want me to test it on additional
hardware. Dominik sent me some great patches to use the cpufreq table support 
and remove some redundant code - let me know if you do not have them and
want me to forward them. They work great.

powernow-k8-acpi sounds like a fine plan to me. Keeping the k8 in the name 
is goodness.

Dave had a good idea of a minimal ACPI parser for trying to retrieve the
table of p-states from an ACPI BIOS without needing the full AML interpreter.
I will see if I can get that to work in powernow-k8-acpi ... that way, there
is the best chance of being able to work around a broken BIOS. I hate broken
BIOSs and would rather see the BIOS vendor fix the BIOS, but that does not
always seem to happen.

Paul.

