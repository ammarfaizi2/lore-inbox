Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTFPPMD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 11:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTFPPMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 11:12:03 -0400
Received: from ns.suse.de ([213.95.15.193]:48910 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263866AbTFPPMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 11:12:01 -0400
Date: Mon, 16 Jun 2003 17:25:54 +0200
From: Andi Kleen <ak@suse.de>
To: mikpe@csd.uu.se
Cc: ak@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz
Subject: Re: [PATCH][2.5.71] x86-64 apic/nmi cleanups
Message-ID: <20030616152554.GH26583@wotan.suse.de>
References: <16109.56877.239305.852139@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16109.56877.239305.852139@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 05:11:41PM +0200, mikpe@csd.uu.se wrote:
> Andi,
> 
> The driver model conversion left x86-64's apic.c and nmi.c with
> obsolete #includes and comments, and some poor code formatting.

Most of this is already in the patchkit.

> 
> nmi.c also lacks the 'nmi_pm_active' change which went into
> i386 recently. It's needed to prevent enabling the watchdog
> after resume if it was disabled before suspend: this happens
> if another driver has claimed the HW and disabled the watchdog.
> This won't hit until you remove the #if 0 in lapic_nmi_resume(),
> however. (Why do you need that?)

I think it came from Pavel. I will remove it for now and merged that
change.

-Andi
