Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWAUWtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWAUWtP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWAUWtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:49:15 -0500
Received: from main.gmane.org ([80.91.229.2]:33002 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751214AbWAUWtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:49:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Carlo J. Calica" <ccalica@gmail.com>
Subject: Re: Strange interrupt errors on ASUS A8N-SLI Premium
Date: Sat, 21 Jan 2006 14:54:43 -0800
Message-ID: <dqudos$4fg$1@sea.gmane.org>
References: <43D24D4A.2080301@scientia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 67-42-159-46.ptld.qwest.net
User-Agent: KNode/0.9.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Anton Mitterer wrote:

> Hi.
> 
> Yesterday I've assebled the new PC of a friend and when we finished we
> tried to adapt his kernelconfiguration to the new hardware,...
> But when we were finished we had some strange errors.
> 
> Perhaps you can help us.... the hardwareconfiguration is the following:
> - AMD Athlon64 X2 4400 +
> - ASUS A8N-SLI Premium
> - Kingston ECC RAM 2 GB
> - PATA Samsung HDD connected via hard drive mobile rack
> 

I have a similar setup.  (Using SATA instead).  I boot with ACPI=off and
(irqfixup if using the onboard nv SATA controller).  Make sure your BIOS is
set to a non-pnp OS.  

In addition, I'm having some sort of race between X and keyboard driver
(seem to interact with SATA too).  I solved that by setting CPU affinity to
the same processor for X and the keyboard IRQ handler.

Booting with apic=verbose might give some useful output as well.

Good luck, I've beating my head against the MB since I got it.

