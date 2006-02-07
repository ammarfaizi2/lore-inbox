Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWBGX72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWBGX72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWBGX72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:59:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61964 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030288AbWBGX72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:59:28 -0500
Date: Tue, 7 Feb 2006 23:59:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux PM <linux-pm@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Complain if driver reenables interrupts during drivers_[suspend|resume] & re-disable
Message-ID: <20060207235911.GB26558@flint.arm.linux.org.uk>
Mail-Followup-To: Nigel Cunningham <ncunningham@cyclades.com>,
	Linux PM <linux-pm@osdl.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <200602071906.55281.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602071906.55281.ncunningham@cyclades.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 07:06:48PM +1000, Nigel Cunningham wrote:
> This patch is designed to help with diagnosing and fixing the cause of
> problems in suspending/resuming, due to drivers wrongly re-enabling
> interrupts in their .suspend or .resume methods. 

Sorry, aren't interrupts enabled at this point anyway?  They are if
you issue a suspend to RAM via sysfs, eg:

state_store->enter_state->suspend_prepare->device_suspend->suspend_device

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
