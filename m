Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWFGTba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWFGTba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 15:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWFGTba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 15:31:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54797 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932204AbWFGTba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 15:31:30 -0400
Date: Wed, 7 Jun 2006 20:31:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Victor <andrew@sanpeople.com>
Cc: linux-kernel@vger.kernel.org, alessandro.zummo@towertech.it, akpm@osdl.org
Subject: Re: [PATCH] RTC: Ensure that time being passed to set_alarm() is valid.
Message-ID: <20060607193121.GG13165@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Victor <andrew@sanpeople.com>,
	linux-kernel@vger.kernel.org, alessandro.zummo@towertech.it,
	akpm@osdl.org
References: <1149704455.20386.90.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149704455.20386.90.camel@fuzzie.sanpeople.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 08:20:55PM +0200, Andrew Victor wrote:
> RTC: Ensure that the time being passed to set_alarm() is valid.

NAK.  rtc_valid_tm checks that the time/date is valid (eg, month is
within range).  Alarms can have a "don't care" state for each part -
for example, setting month to 0xff means "alarm every month".

See the API exposed by /dev/rtc on x86 by virtue of being the
MC146818 register set.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
