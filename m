Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWAPJBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWAPJBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWAPJBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:01:34 -0500
Received: from smtpout06-01.prod.mesa1.secureserver.net ([64.202.165.224]:31910
	"HELO smtpout06-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1751082AbWAPJBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:01:33 -0500
Message-ID: <43CB60E4.1060305@sairyx.org>
Date: Mon, 16 Jan 2006 20:01:24 +1100
From: Arlen Christian Mart Cuss <celtic@sairyx.org>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.15] screen remains blank after LID switch use
References: <200601160946.51765.lkml@kcore.org>
In-Reply-To: <200601160946.51765.lkml@kcore.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check out /proc/acpi - you should find a few things that you can tinker 
with, including one for your screen; often called `lcd'. If you "echo 1 
 > lcd" in the right directory, it should switch it on. "echo 0 > lcd" 
switches it off. Whatever is managing your power that turns it off, 
isn't turning it back on. Look into these. It's not likely to be the 
console/X driver's fault.

 - Arlen.

Jan De Luyck wrote:

>(I have no idea who the maintainer for this is, I was unable to find any entry 
>in the MAINTAINERS file.. if i overlooked it, feel free to correct me)
>
>Hello list,
>
>
>I've recently gotten an Dell D610 laptop from my company. After some digging I 
>managed to get Linux running on it, with kernel 2.6.15 at this moment.
>
>There is something odd going on with the LID switch functionality tho: 
>everytime the LID is closed, the screen goes off, as expected. Unfortunately, 
>the screen does not come back alive afterwards, it remains blank.
>
>Starting X doesn't help, switching consoles doesn't help either. The problem 
>is appareant both in X and the console.
>
>The laptop remains completely functional, except for the display.
>
>Currently I'm not using a fb console, and the X driver is the i810.
>
>Any ideas?
>
>Thanks,
>
>Jan
>  
>

