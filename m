Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVAES2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVAES2m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVAES2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:28:42 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:34690 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262536AbVAES2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:28:40 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9+ keyboard LED problem
Date: Wed, 5 Jan 2005 13:28:37 -0500
User-Agent: KMail/1.6.2
Cc: Meelis Roos <mroos@linux.ee>
References: <Pine.SOC.4.61.0501051856090.9146@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0501051856090.9146@math.ut.ee>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501051328.37849.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 January 2005 12:04 pm, Meelis Roos wrote:
> 
> The input changes in 2.6.9 made keyboard LED setting unreliable. 2.6.8 
> is OK, 2.6.9, 2.6.10 and todays BK are buggy.
> 
> The problem is that setting the LEDs now interferes with keyboard and 
> ps/2 mouse input and makes the kernel lose key press and key release 
> events.
> 
> Short demonstation:
> #!/bin/sh
> while :; do xset led 3; xset -led 3; sleep 0.01; done
> 
> This script works from X but the same effect can be seen on the console 
> using setleds. The problem was found with ledcontrol package but is 
> easyly reproduced with the script above.
> 
> Key press and release events are lost, mouse movement is lost or 
> movement is converted into clicks or mouse loses sync (by dmesg info). 
> There are also messages like
> atkbd.c: Unknown key released (translated set 2, code 0xe0 on isa0060/serio0).
> atkbd.c: Use 'setkeycodes e060 <keycode>' to make it known.
> in dmesg.
> 
> Don't try the script without the sleep command unless you have a network 
> connection to log in and kill the script ;)
> 

Seems to work fine here. The led is blinking rapidly but I can type just
fine and touchpad works as well.

What kind of box do you have? UP/SMP, Preempt?

-- 
Dmitry
