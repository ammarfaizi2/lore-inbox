Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUHKBrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUHKBrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 21:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267870AbUHKBrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 21:47:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54258 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267869AbUHKBrl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 21:47:41 -0400
Message-ID: <41197ABA.6080107@mvista.com>
Date: Tue, 10 Aug 2004 18:47:38 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@digitalimplant.org>
CC: linux-kernel@vger.kernel.org, pavel@ucw.cz, benh@kernel.crashing.org,
       david-b@pacbell.net
Subject: Re: [RFC] Fix Device Power Management States
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Divorcing device power states from ACPI-defined integers would be very 
nice for embedded platforms.  Usually the platform bus would be 
involved.  Since the proposal tends to place more responsibility on the 
bus driver, I'm interested in the intended usage for platform devices. 
For example, are platform_device callbacks for 
suspend/resume/save/restore of the particular device still needed?  How 
does the platform bus driver map (platform-specific?) system states to 
device states?

Customizing the available system power states based on the platform is 
even more desirable.  But the generic sys_pm_* ids might still be the 
best way to hook up the platform-specific code to the generic PM layer 
(and the system-state-to-device-state mapping would still be based on 
the generic ids).  The device suspend/resume decisions we've had to make 
in response to system states have usually been related to properties of 
the system state that could be represented in platform-independent 
fashion, for example, whether the suspend state involves power cycling 
the particular device.

I may be misunderstanding the intent or delving too far into details, 
but I'd be happy to help with embedded platform stuff if there's 
interest, thanks,

-- 
Todd Poynor
MontaVista Software

