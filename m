Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264910AbUELHWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbUELHWW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 03:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264995AbUELHWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 03:22:22 -0400
Received: from stormdbn.stormnet.co.za ([196.22.196.1]:28059 "EHLO
	stormdbn.stormnet.co.za") by vger.kernel.org with ESMTP
	id S264910AbUELHWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 03:22:20 -0400
Subject: Re: weird clock problem
From: Nelis Lamprecht <nelis@brabys.co.za>
Reply-To: nelis@brabys.co.za
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <40A1CC90.3040609@aitel.hist.no>
References: <1084282171.8334.46.camel@nelis.brabys.co.za>
	 <40A1CC90.3040609@aitel.hist.no>
Content-Type: text/plain
Organization: Brabys Holdings
Message-Id: <1084346537.6186.4.camel@nelis.brabys.co.za>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 09:22:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-12 at 09:04, Helge Hafting wrote:

> >
> Take a look at /proc/interrupts. Is the timer interrupt
> shared with something?
> 

Doesn't look like it.

           CPU0       CPU1
  0:     153901         18    IO-APIC-edge  timer
  1:         89          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  9:          0          0   IO-APIC-level  acpi
 12:       9271          0    IO-APIC-edge  i8042
 14:       5045          0    IO-APIC-edge  ide0
 15:         43          0    IO-APIC-edge  ide1
 16:       9582          0   IO-APIC-level  uhci_hcd, uhci_hcd, nvidia
 17:          0          0   IO-APIC-level  Intel ICH5
 18:          0          0   IO-APIC-level  uhci_hcd
 19:          0          0   IO-APIC-level  uhci_hcd
 21:        847          0   IO-APIC-level  eth0
 23:          0          0   IO-APIC-level  ehci_hcd
NMI:          0          0
LOC:     153821     153833
ERR:          0
MIS:          0


Regards,
Nelis

