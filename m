Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261383AbSJEXDu>; Sat, 5 Oct 2002 19:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262793AbSJEXDt>; Sat, 5 Oct 2002 19:03:49 -0400
Received: from uucp.gnuu.de ([151.189.0.84]:17171 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id <S261383AbSJEXDs>;
	Sat, 5 Oct 2002 19:03:48 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 - no keyboard
References: <F134x4FR0rmTIVvLVKi0000fe8b@hotmail.com>
	<1033857702.742.4389.camel@phantasy>
From: krause@sdbk.de (Sebastian D.B. Krause)
Date: Sun, 06 Oct 2002 01:08:29 +0200
In-Reply-To: <1033857702.742.4389.camel@phantasy> (Robert Love's message of
 "Sun, 06 Oct 2002 00:50:06 +0200")
Message-ID: <8765wg32mq.fsf@sdbk.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
> On Sat, 2002-10-05 at 18:37, sean darcy wrote:
>> I've built 2.5.40 on a rh8.0 athlon box.  It boots up OK, but NO keyboard.
>> 
>> It's  a vanilla MS natural keyboard with a small DIN PS/2 connector - not 
>> USB. Works fine with 2.4.19 - even prior 2.5.x's.
>> 
>> I noticed that xconfig  Input device support grays out 
>> CONFIG_KEYBOARD_ATKBD. As a test, I hand edited .config. Still didn't work.
>
> You need to enable serio first.  Something like this:
>
> 	CONFIG_SERIO=y
> 	CONFIG_SERIO_I8042=y
> 	CONFIG_KEYBOARD_ATKBD=y
>
> should work.

I had the same problem (no keyboard, but I had this problem with all
prior 2.5.x) as Sean, although I had the correct configuration as
you show above. It seems that this problem has something to do with
devfs, because everything worked (even X11, which didn't run, too)
well after I disabled it.

Sebastian
