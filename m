Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268957AbUJUJQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268957AbUJUJQF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268819AbUJUJPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:15:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34569 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268978AbUJUJOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:14:10 -0400
Date: Thu, 21 Oct 2004 10:13:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] Input: remove pm_dev from core
Message-ID: <20041021101358.B3089@flint.arm.linux.org.uk>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Vojtech Pavlik <vojtech@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>
References: <200410210223.45498.dtor_core@ameritech.net> <200410210228.57067.dtor_core@ameritech.net> <200410210229.33358.dtor_core@ameritech.net> <200410210230.04156.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200410210230.04156.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Thu, Oct 21, 2004 at 02:30:02AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 02:30:02AM -0500, Dmitry Torokhov wrote:
> ChangeSet@1.1971, 2004-10-20 00:57:45-05:00, dtor_core@ameritech.net
>   Input: get rid of pm_dev in input core as it is deprecated and
>          nothing uses it anyway.

You might as well remove it completely - anything which uses the
driver model PM implementation will never call these methods, and
ARM uses the driver model PM implementation.

Therefore, any driver using the obsolete pm_register() functions
won't receive any PM events.

Same is true on x86 btw.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
