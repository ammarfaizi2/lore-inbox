Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWGJBMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWGJBMw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 21:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWGJBMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 21:12:52 -0400
Received: from terminus.zytor.com ([192.83.249.54]:23479 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964938AbWGJBMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 21:12:51 -0400
Message-ID: <44B1A982.1060700@zytor.com>
Date: Sun, 09 Jul 2006 18:12:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-input@atrey.karlin.mff.cuni.cz,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Magic Alt-SysRq change in 2.6.18-rc1
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> Dmitry:
> 
> Are you the right person to handle changes in the behavior of Alt-SysRq?
> 
> Before 2.6.18-rc1, I used to be able to use it as follows:
> 
> 	Press and hold an Alt key,
> 	Press and hold the SysRq key,
> 	Release the Alt key,
> 	Press and release some hot key like S or T or 7,
> 	Repeat the previous step as many times as desired,
> 	Release the SysRq key.
> 
> This scheme doesn't work any more, or if it does, the timing requirements
> are now much stricter.  In practice I have to hold down all three keys at
> the same time; I can't release the Alt key before pressing the hot key.
> 
> This makes thinks very awkward on my laptop machine.  Its keyboard
> controller doesn't seem to like having three keys pressed simultaneously.  
> Instead of the expected hotkey behavior, I usually got an error message
> from atkbd warning about too many keys being pressed.  Getting it to work
> as desired is hit-and-miss.
> 
> I would really appreciate going back to the old behavior, where only two 
> keys needed to be held down at any time.
> 

Looks like the current keyboard code lets you press Alt-SysRq, 
Alt-<letter> without keeping the SysRq key held down, as long as you 
don't release the Alt key.

That seems a lot more user-friendly to me.

	-hpa
