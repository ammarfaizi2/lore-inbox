Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVCBC7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVCBC7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 21:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbVCBC7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 21:59:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:15557 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262147AbVCBC7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 21:59:50 -0500
Subject: Re: [linux-pm] [PATCH] Custom power states for non-ACPI systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
In-Reply-To: <20050302020306.GA5724@slurryseal.ddns.mvista.com>
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 13:57:16 +1100
Message-Id: <1109732236.5680.89.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 18:03 -0800, Todd Poynor wrote:
> Advertise custom sets of system power states for non-ACPI systems.
> Currently, /sys/power/state shows and accepts a static set of choices
> that are not necessarily meaningful on all platforms (for example,
> suspend-to-disk is an option even on diskless embedded systems, and the
> meaning of standby vs. suspend-to-mem is not well-defined on
> non-ACPI-systems).  This patch allows the platform to register power
> states with meaningful names that correspond to the platform's
> conventions (for example, "big sleep" and "deep sleep" on TI OMAP), and
> only those states that make sense for the platform.
> .../...

Note that I'd like to rework the whole notion of power states
ultimately. Devices themselves need custom state if we want anything
sane other than global system wide suspend.

Ben.


