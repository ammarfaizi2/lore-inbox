Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVACTNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVACTNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVACTN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:13:27 -0500
Received: from orb.pobox.com ([207.8.226.5]:30867 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261526AbVACRZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:25:06 -0500
Date: Mon, 3 Jan 2005 09:24:59 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Francisco Martins <fmartins@di.fc.ul.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend/resume to disk problem
Message-ID: <20050103172459.GA4194@ip68-4-98-123.oc.oc.cox.net>
References: <1104715228.8402.34.camel@pad.di.fc.ul.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104715228.8402.34.camel@pad.di.fc.ul.pt>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 01:20:28AM +0000, Francisco Martins wrote:
> Hi all,
> 
> I'm using Debian GNU/linux 3.1 with kernel 2.6.10 on my IBM Thinkpad
> R40, and I'm experiencing a strange problem with suspend to disk.
> 
> If I configure the kernel options 
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=y
> # CONFIG_PM_DEBUG is not set
> CONFIG_SOFTWARE_SUSPEND=y
> CONFIG_PM_STD_PARTITION="/dev/hda5",

AFAIK the typical way people do it (or at least what I'm doing, which
isn't hitting this bug) is to set CONFIG_PM_STD_PARTITION to "" then to
add (in your case) "resume=/dev/hda5" to the kernel boot command line.

This won't really fix your bug, but it should let you use swsusp in the
meantime.

-Barry K. Nathan <barryn@pobox.com>

