Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVCDOhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVCDOhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 09:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVCDOhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 09:37:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10651 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262614AbVCDOeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 09:34:01 -0500
Date: Fri, 4 Mar 2005 15:11:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11: suspending laptop makes system randomly unstable
Message-ID: <20050304141159.GE3485@openzaurus.ucw.cz>
References: <422618F0.3020508@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422618F0.3020508@telefonica.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I just compiled 2.6.11 from a 2.6.10 configuration for a desktop 
> machine (with kernel preemption activated).
> Doing a make oldconfig bring some new options. I selected the default 
> value (for my system) for them, so I keep configuring "make great 
> kernel lock preemtive" to true (complete kernel configuration 
> follows).
> 
> Apart from the ALPS touchpad thing (see "2.6.11: touchpad 
> unresponsive"), the new kernel keeps:

3 different problems, I'd say.

>    - Setting randomly "last battery full charge" to a huge value 
> (example: 400 Ah when max battery capacity is 38 Ah) so I get random 
> charging/discharging timing patterns

try echo platform > disk.

>    - Locking "softly" the system: for example, preventing new 
>    proceses from spawning. For example, if I suspend the laptop while in 
> Xwindows, resuming will keep X but new proceses can't be started. 
> Changing to a virtual console doesn't get past the login step, as a 
> new shell can't be started.

Find out what prevents them from being started or find reproducible way
to trigger it...

>    - Disabling/enabling  double-clicks in the synaptic touchpad. 
>    Randomly.

input problem, ask vojtech.


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

