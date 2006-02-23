Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbWBWJZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbWBWJZA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbWBWJZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:25:00 -0500
Received: from cantor.suse.de ([195.135.220.2]:8068 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751697AbWBWJY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:24:59 -0500
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86_64: warn if unable to configure apic main timer
Date: Thu, 23 Feb 2006 10:24:38 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200602230420_MC3-1-B90E-39AF@compuserve.com>
In-Reply-To: <200602230420_MC3-1-B90E-39AF@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231024.38599.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 10:17, Chuck Ebbert wrote:
> When using the APIC main timer option on x86_64, sometimes it
> fails to complete its setup.  Warn about this and suggest
> the user try 'disable_timer_pin_1' if their system clock runs
> too fast. Also, make printing of the exact result of APIC
> timer calibration require 'apic=verbose'.

This is not the right solution. Have to find out what's going
wrong and fix that.

I'm also experimenting with a different way to run the timer
because apicmaintimer doesn't work on a lot of laptops
because they have trouble running the APIC timer during c2.

-Andi
