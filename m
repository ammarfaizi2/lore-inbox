Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318120AbSGMH6o>; Sat, 13 Jul 2002 03:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318121AbSGMH6n>; Sat, 13 Jul 2002 03:58:43 -0400
Received: from mail14.speakeasy.net ([216.254.0.214]:35975 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S318120AbSGMH6n>; Sat, 13 Jul 2002 03:58:43 -0400
Subject: Re: kbd not functioning in 2.5.25-dj2
From: Ed Sweetman <safemode@speakeasy.net>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020713073717.GA9203@wizard.com>
References: <1026545050.1203.116.camel@psuedomode> 
	<20020713073717.GA9203@wizard.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 13 Jul 2002 04:01:32 -0400
Message-Id: <1026547292.1224.132.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.18 is the last time it worked for me I have basically the same exact
config, the new input system seems to have undergone some changes since
then though and now it's not behaving.  I will try setting the XTKBD
setting and PS2SEDKBD or whatever it is.  


On Sat, 2002-07-13 at 03:37, A Guy Called Tyketto wrote:
> On Sat, Jul 13, 2002 at 03:24:09AM -0400, Ed Sweetman wrote:
> > Same config as in my last post about the issue linking with this
> > kernel.  I'm having my keyboard just not respond from boot.  I've got
> > Input Device support built in and i had it as module and the keyboard is
> > ps/2.  No idea what's going on here 
> > 
> 
>         Just a "me too" here.. I've had this problem since around 2.5.15-dj 
> and later, and have had input and keyboard support compiled into the kernel. 
> Luckily I was able to get into the box via ssh, and check things. both 
> keyboard and mouse are PS/2. If possible, see if you can do this, and check if 
> IRQ 1 is not listed in /proc/interrupts. That is what is happening with me, 
> while my mouse is working. For me to get my keyboard to work, I have to have 
> the following set:
> 
> CONFIG_INPUT=y
> CONFIG_INPUT_KEYBDEV=y
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_EVDEV=y
> CONFIG_INPUT_EVBUG=y
> CONFIG_SERIO=y
> CONFIG_SERIO_SERPORT=m
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> CONFIG_KEYBOARD_XTKBD=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> 
>         This leaves me without using the new Input API, but with a working 
> keyboard. with using the new API, mouse will work, keyboard will not. you can 
> try these, and use the old setup (I assume will be made legacy by the time 2.6 
> comes out), and let me know if they work. The new API seems to be working for 
> some people, but not all.
> 
>                                                         BL.
> -- 
> Brad Littlejohn                         | Email:        tyketto@wizard.com
> Unix Systems Administrator,             |           tyketto@ozemail.com.au
> Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
>   PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


