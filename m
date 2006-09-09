Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWIIQoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWIIQoI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 12:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWIIQoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 12:44:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40660 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932176AbWIIQoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 12:44:04 -0400
Date: Sat, 9 Sep 2006 12:51:05 -0400
From: Dave Jones <davej@redhat.com>
To: Reinaldo Carvalho <reinaldow@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: agpgart v0.101 problem AMD K8 NorthBridge
Message-ID: <20060909165105.GA4743@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Reinaldo Carvalho <reinaldow@gmail.com>,
	linux-kernel@vger.kernel.org
References: <ec36785a0609090811m5ded669alc5e1bf361ca37b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec36785a0609090811m5ded669alc5e1bf361ca37b4@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 12:11:48PM -0300, Reinaldo Carvalho wrote:
 > agpgart detect incorrect aperture size (is set to 128Mb)
 > ..
 > 0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
 > 90: 01 00 00 00 70 10 00 00 00 d2 1f 00 00 00 00 00
       ^^
This means 32MB.
If your BIOS is claiming its 128MB, it's either wrong, or programming
something else (possibly the on-chipset GART [which we don't use] instead
of the on-CPU GART)

 > and X crash when use nvidia driver (any version). kernel 2.6.17

No idea, and sadly, on probably only nvidia will be able to diagnose this.
 
	Dave
