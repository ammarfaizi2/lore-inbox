Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVAOWYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVAOWYf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 17:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVAOWYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 17:24:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:52155 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262334AbVAOWYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 17:24:33 -0500
Subject: Re: [PATCH] PPC64 pmac hotplug cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Linux PPC64 <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501122341410.23299@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0501122341410.23299@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Sun, 16 Jan 2005 09:23:13 +1100
Message-Id: <1105827794.27410.82.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 17:43 -0700, Zwane Mwaikambo wrote:
> I found the following very handy for use as a reference platform when 
> working on i386 hotplug cpu recently.
> 
> It's been tested on a G5 system with a cpu going on/offline every second 
> and make -j. I've also tried a number of config options to avoid compile 
> breakage.

Hi !

Looks good, but you could do even better :) I still want to look at the
proper mecanism to flush the CPU cache on 970, but the idea here is to
flush it, and put the CPU into a NAP loop (the 970 has no SLEEP mode)
with the caches clean and MSR:EE off. We can later get it back with a
soft reset.

Ben.

