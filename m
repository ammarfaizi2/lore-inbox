Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUAIQrF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 11:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbUAIQrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 11:47:05 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:60352 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S262055AbUAIQrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 11:47:02 -0500
From: lkml@nitwit.de
To: linux-kernel@vger.kernel.org
Subject: 2.6: The hardware reports a non fatal, correctable incident occured on CPU 0.
Date: Fri, 9 Jan 2004 17:48:10 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401091748.10859.lkml@nitwit.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I did have some very scary issues today playing with 2.6. The system was 
booted and ran several times today, the longtest uptime was approximately 
about an hour.

But then shortly after having booted 2.6 I got syslog messages: 

The hardware reports a non fatal, correctable incident occured on CPU 0.

I shut down the machine. After this my Athlon XP 2200+ showed up as 1050MHz in 
BIOS an indeed the bus frequency was set to 100 instead of 133 MHz (how can 
an OS change the BIOS?!) - nevertheless the CPU should have shown up as 
1500MHz. I set it back to 133 MHz - which resulted in the machine did not 
even reach the BIOS no more but was rebooting automatically prior to it. I 
turned off the machine for some seconds - no change. I turned it off for a 
few minutes and the BIOS showed up again - with 1050MHz. So I had to set the 
freq back to 133 MHz a second time. I booted my 2.4.21 kernel which seems to 
run.

What the fuck is going on here?? As far as I figured out this has something to 
do with MCE (CONFIG_X86_MCE=y, CONFIG_X86_MCE_NONFATAL=y) (?).

TIA
Timo

