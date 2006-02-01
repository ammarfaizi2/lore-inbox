Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbWBARAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWBARAU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWBARAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:00:20 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:50416 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1161102AbWBARAT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:00:19 -0500
Date: Wed, 1 Feb 2006 12:00:12 -0500
From: "George G. Davis" <gdavis@mvista.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: Add spin_lock_init() in 8250 early_serial_setup() to init port.lock
Message-ID: <20060201170012.GO7405@mvista.com>
References: <20060126032403.GG5133@mvista.com> <20060131.003927.112625901.anemo@mba.ocn.ne.jp> <20060201154549.GE7405@mvista.com> <20060202.010118.126574883.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202.010118.126574883.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 01:01:18AM +0900, Atsushi Nemoto wrote:
> >>>>> On Wed, 1 Feb 2006 10:45:49 -0500, "George G. Davis" <gdavis@mvista.com> said:
> 
> gdavis> uart_set_options() is only called from
> gdavis> serial8250_console_setup() when 8250 serial devices have
> gdavis> already been registered via serial8250_isa_init_ports() (for
> gdavis> legacy devices only though AFAICT).
> 
> OK, I see.  Then, please look at this patch in 2.6.16-rc1-mm4.
> 
> serial-initialize-spinlock-for-port-failed-to-setup.patch
> 
> Does this fix your problem ?

That fixes the problem.  Thanks!

--
Regards,
George
