Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVKSXpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVKSXpi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 18:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVKSXpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 18:45:38 -0500
Received: from mail.gondor.com ([212.117.64.182]:54285 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1751039AbVKSXpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 18:45:38 -0500
Date: Sun, 20 Nov 2005 00:45:39 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Bart Samwel <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org, Zhu Yi <yi.zhu@intel.com>,
       Bradley Chapman <kakadu@gmail.com>
Subject: Re: Laptop mode causing writes to wrong sectors?
Message-ID: <20051119234538.GA12485@knautsch.gondor.com>
References: <20051116181612.GA9231@knautsch.gondor.com> <20051117223340.GD14597@elf.ucw.cz> <437E215E.30500@tmr.com> <20051118232019.GA2359@spitz.ucw.cz> <437EE4B3.2090408@samwel.tk> <20051119140527.GA4725@knautsch.gondor.com> <20051119153024.GB4725@knautsch.gondor.com> <437FB53D.6070709@samwel.tk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437FB53D.6070709@samwel.tk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 12:29:01AM +0100, Bart Samwel wrote:
> Remaining issue: this bug is only triggered when the ipw2200 driver does 
> firmware restarts, which generates kernel output "ipw2200: Firmware 
> error detected.  Restarting". Jan, Bradley, do you see any of these 
> messages in your logs near the time of corruption? That should be within 

The "Firmware error detected" message occurs regularly - fortunately, on
my system they cause no significant performance problem. If I understand
the code correctly, writes to the wrong memory location only happen at
the first firmware restart. (Unless certain debugging flags are set,
which isn't the case here.) So, basically, it happens exactly once after
each reboot, after a few minutes of network activity.

It's difficult to know the exact time when the filesystem corruption
happened, as it usually isn't noticed immediately.

Jan

