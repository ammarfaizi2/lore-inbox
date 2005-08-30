Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbVH3MUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbVH3MUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 08:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbVH3MUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 08:20:30 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.27]:42578 "EHLO smtp4.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751413AbVH3MU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 08:20:29 -0400
X-ME-UUID: 20050830122026309.4B9DD1C0017F@mwinf0408.wanadoo.fr
Date: Tue, 30 Aug 2005 14:24:16 +0200
From: Philippe Elie <phil.el@wanadoo.fr>
To: Chase Venters <chase.venters@clientec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Second "CPU" of 1-core HyperThreading CPU not found in 2.6.13
Message-ID: <20050830122416.GD848@zaniah>
References: <200508292303.52735.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508292303.52735.chase.venters@clientec.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2005 at 23:03 +0000, Chase Venters wrote:

> Greetings kind hackers...
> 	I recently switched to 2.6.13 on my desktop. I noticed that the second 
> "CPU" (is there a better term to use in this HyperThreading scenario?) that 
> used to be listed in /proc/cpuinfo is no longer present. Browsing over the 
> archives, it appears as if someone else had this problem... their solution 
> was to enable CONFIG_PM, but I already have CONFIG_PM enabled.
> 	I have to boot with 'noapic' because I have my CD-Writer hanging off an 
> aic7xxx, and that driver goes into a nice error loop if I boot without it. 
> 	I'll include some lspci output below in case it is useful. There's one more 
> thing I noticed in the transition to 2.6.13, but I'm really not sure where I 
> could start diagnosing it, and so any suggestions would be marvelous. 
> 	As I mentioned, this machine is my desktop. In the past, I've been able to 
> run compilers / other intensive tasks while listening to music in XMMS - the 
> playback is never disrupted (indeed, on this P4 3.2ghz XMMS takes virtually 
> none of the processor). Yet I've noticed enough momentary stops in sound 
> output now to begin to suspect I've got some kind of problem. 
> 	Last kernels that were functional in both regards were 2.6.12.4 and 2.6.11.7. 
> Please note that I have not compiled with the new default tick rate of 250Hz 
> - I'm running 1000Hz, and I have also enabled the Preemptible kernel and BKL 
> Preemption as I have in earlier kernels.

I needed CONFIG_PM=y and CONFIG_ACPI=y to get ht working on 2.6.13.

regards,
Philippe Elie

