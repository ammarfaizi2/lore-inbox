Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWFGTdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWFGTdS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 15:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWFGTdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 15:33:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56589 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932372AbWFGTdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 15:33:17 -0400
Date: Wed, 7 Jun 2006 20:33:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Victor <andrew@sanpeople.com>
Cc: linux-kernel@vger.kernel.org, alessandro.zummo@towertech.it, akpm@osdl.org
Subject: Re: [PATCH[ RTC: Add rtc_year_days() to calculate tm_yday
Message-ID: <20060607193311.GH13165@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Victor <andrew@sanpeople.com>,
	linux-kernel@vger.kernel.org, alessandro.zummo@towertech.it,
	akpm@osdl.org
References: <1149704768.20154.95.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149704768.20154.95.camel@fuzzie.sanpeople.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 08:26:09PM +0200, Andrew Victor wrote:
> RTC: Add exported function rtc_year_days() to calculate the tm_yday
> value.

Is there a good reason for this?  I ask the question because the x86
/dev/rtc driver says:

         * Only the values that we read from the RTC are set. We leave
         * tm_wday, tm_yday and tm_isdst untouched. Note that while the
         * RTC has RTC_DAY_OF_WEEK, we should usually ignore it, as it is
         * only updated by the RTC when initially set to a non-zero value.

So it seems the established modus operandi for RTC interfaces is "don't
trust wday, yday and isdst".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
