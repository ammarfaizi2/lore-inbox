Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbULCRhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbULCRhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbULCRhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:37:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:1232 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262399AbULCRf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:35:56 -0500
Message-ID: <41B0A0BE.3070107@osdl.org>
Date: Fri, 03 Dec 2004 09:22:06 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Warne <nick@linicks.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: newbie kernel hacking question.
References: <200412031715.15067.nick@linicks.net>
In-Reply-To: <200412031715.15067.nick@linicks.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:
> Hi all,
> 
> I am trying to learn more in operation of kernel, and decided to attempt some 
> small hacks with a meaningful purpose - 'see it in action' type stuff rather 
> than just play.
> 
> One area to start with I decided is the keyboard warning at boot.  I have 5 
> headless/keyboardless boxes and wish the kernel to stop reporting I have no 
> keyboard at boot(I KNOW!!).
> 
> I finally located where kb gets initialized.
> 
> Is it this simple just to undef this in /include/linux/pc_keyb.h
> 
> #define KBD_REPORT_TIMEOUTS             /* Report keyboard timeouts */
> 
> I have read code through, and it appears the right thing to do (and it's so 
> simple I am in doubt it is this easy), but I am loath to try it in case the 
> box doesn't come up and I will have to fart around getting out monitor and kb 
> and move my sofa for access and stuff...
> 
> Thanks for any help.

Yes, it looks like that should do it in Linux 2.4.x.
The keyboard driver isn't the same in 2.6.x....

-- 
~Randy
