Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTLEEmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 23:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTLEEmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 23:42:49 -0500
Received: from hoemail1.lucent.com ([192.11.226.161]:38323 "EHLO
	hoemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263172AbTLEEmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 23:42:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16336.3156.134104.991694@gargle.gargle.HOWL>
Date: Thu, 4 Dec 2003 23:40:52 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: John Stoffel <stoffel@lucent.com>, grundig@teleline.es,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP Kernel 2.6.0-test11 doesn't boot on a Dell 410
In-Reply-To: <Pine.LNX.4.58.0312042109140.27578@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0312041607180.27578@montezuma.fsmlabs.com>
	<16335.44623.99755.811085@gargle.gargle.HOWL>
	<Pine.LNX.4.58.0312041702470.27578@montezuma.fsmlabs.com>
	<16335.45013.813891.503104@gargle.gargle.HOWL>
	<Pine.LNX.4.58.0312042109140.27578@montezuma.fsmlabs.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I've compiled and installed 2.6.0-test11 in UP mode and it boots
up and runs just fine on my box.  Here's the /proc/interrupts:

  jfsnew:~> cat /proc/interrupts 
	     CPU0       
    0:    1577189          XT-PIC  timer
    1:       3015          XT-PIC  i8042
    2:          0          XT-PIC  cascade
    5:       2794          XT-PIC  eth0
    8:          4          XT-PIC  rtc
   11:       5421          XT-PIC  aic7xxx, aic7xxx, aic7xxx
   12:       1835          XT-PIC  i8042
   14:       3022          XT-PIC  ide0
   15:       1983          XT-PIC  ide1
  NMI:          0 
  ERR:          0

I suspect it's an APIC issue, I seem to recall having to do something
about this before.  Any way, I'm re-compiling UP, but with the APIC
enabled, but not the IO-APIC stuff.  We'll see how that goes.

Hopefully more tonight, but maybe not.

John
