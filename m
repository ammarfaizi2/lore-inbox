Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVCBWJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVCBWJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVCBWGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:06:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:37043 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262558AbVCBVoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:44:30 -0500
Date: Wed, 2 Mar 2005 13:43:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.11: suspending laptop makes system randomly unstable
Message-Id: <20050302134342.4c9cc488.akpm@osdl.org>
In-Reply-To: <422618F0.3020508@telefonica.net>
References: <422618F0.3020508@telefonica.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net> wrote:
>
> I just compiled 2.6.11 from a 2.6.10 configuration for a desktop machine 
>  (with kernel preemption activated).
>  Doing a make oldconfig bring some new options. I selected the default 
>  value (for my system) for them, so I keep configuring "make great kernel 
>  lock preemtive" to true (complete kernel configuration follows).
> 
>  Apart from the ALPS touchpad thing (see "2.6.11: touchpad 
>  unresponsive"), the new kernel keeps:
> 
>      - Setting randomly "last battery full charge" to a huge value 
>  (example: 400 Ah when max battery capacity is 38 Ah) so I get random 
>  charging/discharging timing patterns

That's an ACPI problem, I assume?

>      - Locking "softly" the system: for example, preventing new proceses 
>  from spawning. For example, if I suspend the laptop while in Xwindows, 
>  resuming will keep X but new proceses can't be started. Changing to a 
>  virtual console doesn't get past the login step, as a new shell can't be 
>  started.

Is there no oops trace?

Could you switch to a vc, hit alt-sysrq-t and reboot, see if you get an
all-task backtrace in the kernel logs and of so, send it?

>      - Disabling/enabling  double-clicks in the synaptic touchpad. Randomly.


>  All of these symthoms are more or less randomly. As far as I can tell, 
>  everything is ok before suspending but does Random Nasty Things(tm) 
>  after coming out from suspension.
