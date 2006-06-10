Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWFJN2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWFJN2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 09:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWFJN2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 09:28:16 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:21666 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751496AbWFJN2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 09:28:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VAQuPfECzOa6zmyqu5WTOi9GrNakI0MUyNKNjFthaWDHQYuNtmvD4lBM7XDTFH7e1c+Lw2/nkI13PXOwnlNUyagzTU1gHf3hOlzj5VftSK/7LqvwGS+uWYJBnz95f7fpiYkbs0X8EBWXW2KkguyT1LTlLHM9KSJsJEVlqXfhzfg=
Message-ID: <448AC8E5.6040106@gmail.com>
Date: Sat, 10 Jun 2006 21:28:05 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] VT binding: Update fbcon to support binding
References: <448933EB.3070003@gmail.com> <200606101310.04174.ioe-lkml@rameria.de>
In-Reply-To: <200606101310.04174.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> Hi Antonio,
> 
> On Friday, 9. June 2006 10:40, Antonino A. Daplas wrote:
>>     5. When fbcon is completely unbound from the console layer, fbcon will
>>        also release (iow, decrement module reference counts to zero) all fbdev
>>        drivers. In other words, a bind or unbind request from the console layer
>>        will propagate down to the framebuffer drivers.
>>
>>     6. If fbcon is not bound to the console, it will ignore all notifier
>>        events (except driver registration and unregistration) and all sysfs
>>        requests.
> 
> Wow! 
> 
> Now one can:
> 
> 	- implement different framebuffer drivers for a chip. 
> 	- try a stable and development version without rebooting,
> 	- have probing with user interaction ("if you see me please 
> 	  press enter else I will try the previous driver in 15 seconds.") 
> 	  instead of deciding on "failsafe" (vga/vesa) and "fast" 
> 	  (special driver) at boot.

Yes, all of the above are possible :-), and with our present user tools,
are currently very, very doable (at least in x86).

> 
> I love it!
> 
> Just the take_over_console() as alternative API looks strange.

It's not an alternative API, it's the default API and behavior. So, I
just can't remove it without breaking all console drivers.

Tony
