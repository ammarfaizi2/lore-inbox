Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132760AbRDQQ5H>; Tue, 17 Apr 2001 12:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132762AbRDQQ44>; Tue, 17 Apr 2001 12:56:56 -0400
Received: from www.transvirtual.com ([205.217.46.36]:48900 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S132760AbRDQQ4m>; Tue, 17 Apr 2001 12:56:42 -0400
Date: Tue, 17 Apr 2001 09:55:57 -0700 (PDT)
From: James Simmons <jsimmons@linux-fbdev.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Guest section DW <dwguest@win.tue.nl>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
Message-ID: <Pine.LNX.4.10.10104170943140.2508-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Yes, but they could be. Changing the Linux keycodes is a major
>> break with compatibility. If the Linux keycodes are to be changed,
>> then they ought to be become something that would allow XFree86
>> to become keyboard-independent. Why invent yet another encoding?
>
>You dont need to break compatibility. We have cooked, raw, semi-raw type
>modes for keyboard right now. We just need to add semi-raw-extended and
>raw-extended

      Why? X was designed with the idea of a input device core. Keyboards
and mice are just a extenstion of this. Now that linux has a universal
input api (/dev/input/eventX) we can wrapper X around this. I'm working on
this for embedded devices. It just plain stupid to have VT support on
something like a hand held iPAQ which doesn't usually have a keyboard
attached. Also having fbcon built in for these devices just takes up
valuable space since without a keybaord it pretty much is a waste. I
rather have fbdev by itself with input support with only serial console
support. Yes several X apps expect keybaord input coming in. Well we just
don't support those apps on a handheld device. X apps that can work
completely with a mouse would work perfectly on these embedded devices
and would be installed. Since X has this nice clean design I really like
to see XFree86 also use this approach. 
       

