Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWJVJWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWJVJWi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 05:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWJVJWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 05:22:38 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:59025 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932304AbWJVJWh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 05:22:37 -0400
Message-ID: <453B385A.60901@drzeus.cx>
Date: Sun, 22 Oct 2006 11:22:34 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: pHilipp Zabel <philipp.zabel@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Use own work queue
References: <20061001124240.16996.34557.stgit@poseidon.drzeus.cx>	 <74d0deb30610070717k17079940ybedbf94dc8af8460@mail.gmail.com>	 <452AB97B.5040309@drzeus.cx>	 <20061013075626.GB28654@flint.arm.linux.org.uk> <74d0deb30610150240y16d6ea92mc96705576b8f0824@mail.gmail.com>
In-Reply-To: <74d0deb30610150240y16d6ea92mc96705576b8f0824@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pHilipp Zabel wrote:
> 
> Thanks, I can work around this by using the rootdelay kernel parameter.
> So does that mean this is the expected behavior, or should I do anything
> in the bootup sequence to make the init process wait for mmc detection?
> 

USB, which has an almost identical problem, usually uses a "sleep" in
initrd.

If you want to be a bit more fancy, you could try to listen to hotplug
events and look for the kernel creating the relevant block device.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
