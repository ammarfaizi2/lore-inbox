Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVG0Fc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVG0Fc1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 01:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVG0Fc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 01:32:27 -0400
Received: from smtp10.wanadoo.fr ([193.252.22.21]:15544 "EHLO
	smtp10.wanadoo.fr") by vger.kernel.org with ESMTP id S261527AbVG0Fc0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 01:32:26 -0400
X-ME-UUID: 20050727053225427.01050280013B@mwinf1007.wanadoo.fr
Subject: Re: PATCH: Assume PM Timer to be reliable on broken board/BIOS
From: Olivier Fourdan <fourdan@xfce.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42E6C86F.3010503@shaw.ca>
References: <4uGpt-2Y3-15@gated-at.bofh.it>  <42E6C86F.3010503@shaw.ca>
Content-Type: text/plain
Organization: http://www.xfce.org
Date: Wed, 27 Jul 2005 07:32:24 +0200
Message-Id: <1122442345.5849.5.camel@shuttle>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 17:34 -0600, Robert Hancock wrote:
> > In a nutshell, sometimes, the PIT/TSC timer runs 3x too fast [1]. That
> > causes many issues, including DMA errors, MCE, and clock running way too
> > fast (making the laptop unusable for any software development). So far,
> > no BIOS update was able to fix the issue for me.
> 
> Shouldn't this be looked into further rather than adding this 
> workaround? Surely Windows is using the PIT as well, so there must be 
> some way to get it to behave properly..

Surely, but I've been desesperatly trying to find the cause w/out
success for months.

My first idea was that the BIOS doesn't set the CPU voltage properly at
boot, so I made up a patch that sets the right fid/vid before any
calibration but that didn't help.

The BIOS is wrong (ie the BIOS reports a 1/3 of the actual CPU speed),
memtest86+ which doesn't use any ACPI or whatever reports wrong time
too, so it's definitely not a Linux bug.

My guess is that Windows reinitialize some register but it's hard to
tell.

Cheers,
Olivier.


