Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWEWOvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWEWOvQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWEWOvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:51:16 -0400
Received: from darla.ti-wmc.nl ([217.114.97.45]:28319 "EHLO smtp.wmc")
	by vger.kernel.org with ESMTP id S932119AbWEWOvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:51:15 -0400
Message-ID: <44732162.6080107@ti-wmc.nl>
Date: Tue, 23 May 2006 16:51:14 +0200
From: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Herman Elfrink <herman.elfrink@ti-wmc.nl>
Subject: Re: [ANNOUNCE] FLAME: external kernel module for L2.5 meshing
References: <44731733.7000204@ti-wmc.nl> <20060523073851.39c3b5fe@localhost.localdomain>
In-Reply-To: <20060523073851.39c3b5fe@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> O
>> Usage
>> =====
>> - Load module:
>>     modprobe flame [debuglevel=]  [flm_topo_timer=]
>>       : debug level, default: 1
>>       : topology check timer (in seconds), default: 5
>> - Open/close a device with:
>>     echo "up   []" > /proc/net/flame/cmd
>>     echo "down " > /proc/net/flame/cmd
>>       : name of FLAME device, e.g. flm0
>>       : comma-separated list of MAC devices (at least one) that are
>>       used below the FLAME device. All of these must be up.
>>     : comma-separated list of MAC addresses of devices
>>       for which traffic should be ignored; each MAC address should
>>       be a semicolon-separated list of 6 hex-pairs
>> - Get current forwarding info from FLAME:
>>     cat /proc/net/flame/fwd
>> - Get nodes/cost information from MACINFO:
>>     cat /proc/net/macinfo
> 
> 
> Use of /proc for an API is no longer desirable. Please rewrite.
> -

hmm, ok, I'm not sure this will happen anytime soon (being a rather low 
priority thing, which is also the reason it's not submitted as patch to 
the kernel and not signed off), but what is currently the desirable method?

Cheers

Simon

PS, I'm replying for my colleague, who will see this Monday at the 
earliest ;-)

