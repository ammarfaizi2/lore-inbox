Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbUJXIzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbUJXIzX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 04:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbUJXIzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 04:55:22 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:48138 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261387AbUJXIzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 04:55:16 -0400
Date: Sun, 24 Oct 2004 10:54:52 +0159
From: Jedi/Sector One <lkml@pureftpd.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Wrong calculation of load average ?
Message-ID: <20041024085514.GA30429@c9x.org>
References: <20041024005142.GA26209@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024005142.GA26209@oscar.prima.de>
X-Operating-System: OpenBSD - http://www.openbsd.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 02:51:42AM +0200, Patrick Mau wrote:
> I'm using a BK snapshot of linux 2.6 from today and have a strange
> problem with an otherwise stable SMP System. The calculated load average
> seems to "wrap around".

  I'm seeing the same behavior on two hosts running 2.6.9-rc4-mm1.

  4K stacks, ACPI in, dual P4 Xeon with ht, 2 Gb RAM, gcc 3.3.4

> root@oscar] cat /proc/interrupts

           CPU0       CPU1       CPU2       CPU3       
  0:  413691994      14885  591126364          0    IO-APIC-edge  timer
  1:       1027          0          0          0    IO-APIC-edge  i8042
  8:          2          0          0          0    IO-APIC-edge  rtc
  9:          0          0          0          0   IO-APIC-level  acpi
 15:         28          0          1          0    IO-APIC-edge  ide1
 18:     186057          0    6578004          0   IO-APIC-level  megaraid
 24:  483544380     131974  554409619      23181   IO-APIC-level  eth2
NMI:          0          0          0          0 
LOC: 1004835629 1004835628 1004835628 1004835626 
ERR:          0
MIS:          0

-- 
My other computer is your Windows box.
