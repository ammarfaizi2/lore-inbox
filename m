Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWEMVaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWEMVaU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 17:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWEMVaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 17:30:19 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:38592 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932188AbWEMVaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 17:30:18 -0400
Date: Sat, 13 May 2006 23:30:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: No DPMS for Console on x86_64
In-Reply-To: <20060513180158.GB2795@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0605132327410.11638@yvahk01.tjqt.qr>
References: <20060513180158.GB2795@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Unfortunately it seems that setterm's powersaving (DPMS) capabilities depend an
> APM support in the kernel and are therefore unavailable on the x86_64
> architecture.
>
> This shortcoming may have seemed unimportant when Opteron started in the server
> segment but there is a growing number of AMD Turion mobiles that could greatly
> benefit from this feature.
>

There are some backlight drivers in the kernel. Currently however the only 
supported device is Sharp Corgi.
Would it be possible to make DPMS signalling a backlight driver? (Without 
the APM overhead.) vgacon for example leaves the backlight on while in X11, 
DPMS is enabled and signals standby after the timeout.


Jan Engelhardt
-- 
