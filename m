Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVGJSIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVGJSIM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVGJSIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:08:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11734 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262001AbVGJSIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:08:11 -0400
Date: Sun, 10 Jul 2005 20:08:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [38/48] Suspend2 2.1.9.8 for 2.6.12: 614-plugins.patch
Message-ID: <20050710180807.GD10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164432753@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164432753@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +unsigned long suspend2_powerdown_method = 5; /* S5 = off */

Constants.....

> +	if (suspend2_powerdown_method == 3 ||
> +	    suspend2_powerdown_method == 4)

Constants...

> +	if (suspend2_powerdown_method == 3 ||
> +	    suspend2_powerdown_method == 4)

Constants...

> +		suspend2_prepare_status(1, 0, "Ready to reboot.");
> +		suspend2_prepare_status(1, 0, "Seeking to enter ACPI state");
> +			suspend2_prepare_status(1, 0, "Preparing to enter ACPI state failed. Using normal powerdown.");
> +			suspend2_prepare_status(1, 0, "Suspending devices failed. Using normal powerdown.");
> +			suspend2_prepare_status(1, 0, "Entering ACPI state failed. Using normal powerdown.");
> +		suspend2_prepare_status(1, 0, "Powering down.");

Too many magical constants here... Plus I don't really like your own
logging subsystem.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
