Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVCUWLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVCUWLo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVCUWLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:11:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:46015 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261933AbVCUWLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:11:01 -0500
Date: Mon, 21 Mar 2005 14:10:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11: suspending laptop makes system randomly unstable
Message-Id: <20050321141049.5d804609.akpm@osdl.org>
In-Reply-To: <422618F0.3020508@telefonica.net>
References: <422618F0.3020508@telefonica.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net> wrote:
>
> I just compiled 2.6.11 from a 2.6.10 configuration for a desktop machine 
> (with kernel preemption activated).
> Doing a make oldconfig bring some new options. I selected the default 
> value (for my system) for them, so I keep configuring "make great kernel 
> lock preemtive" to true (complete kernel configuration follows).
> 
> Apart from the ALPS touchpad thing (see "2.6.11: touchpad 
> unresponsive"), the new kernel keeps:
> 
>     - Setting randomly "last battery full charge" to a huge value 
> (example: 400 Ah when max battery capacity is 38 Ah) so I get random 
> charging/discharging timing patterns
>     - Locking "softly" the system: for example, preventing new proceses 
> from spawning. For example, if I suspend the laptop while in Xwindows, 
> resuming will keep X but new proceses can't be started. Changing to a 
> virtual console doesn't get past the login step, as a new shell can't be 
> started.
>     - Disabling/enabling  double-clicks in the synaptic touchpad. Randomly.
> 
> All of these symthoms are more or less randomly. As far as I can tell, 
> everything is ok before suspending but does Random Nasty Things(tm) 
> after coming out from suspension.
> 
> Well, at least system clock works better than in 2.6.10.
> 
> I will try to deactivate the main kernel lock thingie and see if that helps.
> 

You appear to have about five bugs here.  Do any of them remain in
2.6.12-rc1?
