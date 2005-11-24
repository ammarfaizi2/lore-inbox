Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbVKXJJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVKXJJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 04:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVKXJJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 04:09:03 -0500
Received: from smtp806.mail.ukl.yahoo.com ([217.12.12.196]:20619 "HELO
	smtp806.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751346AbVKXJJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 04:09:00 -0500
Message-ID: <43858329.8050300@gmail.com>
Date: Thu, 24 Nov 2005 09:08:57 +0000
From: Matt Keenan <tank.en.mate@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Cline <nathan.cline@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch to framebuffer
References: <656113ee0511232208n6948c364ke6103b3ef0a54f@mail.gmail.com>
In-Reply-To: <656113ee0511232208n6948c364ke6103b3ef0a54f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Cline wrote:

>Hello, this is my first time posting to this list so please forgive me
>if I'm violating protocol in some way. :)  I've written a patch to the
>framebuffer code to modify its behavior a bit. I am running on a
>dual-headed system and I noticed when I was working in one console on
>one monitor, the console on the other monitor was "frozen", not
>updating itself. After some digging through the code I realized this
>is because the two framebuffer drivers share the same framebuffer code
>which stores a single pointer to the "current" virtual console. If a
>VC is not current it is considered invisible and is not updated. So I
>patched the code to store a pointer for each framebuffer to the
>"foreground" VC on each one. It seems to work well but I'd like to get
>others' input as this is my first time writing any kernel code, and to
>be honest there is so much code it's difficult to get a clear picture
>in my head of how the whole system works.
>I've attached the patches to this message, a small one to
>drivers/video/console/fbcon.h, and a larger one to fbcon.c. I would
>appreciate it if some of you guys could look over this code and look
>for any obvious errors, or better yet, hopefully someone else has a
>multihead system they can try it on. The patches are against the
>latest GIT source tree (torvalds, main branch, 2.6.15rc2) as of last
>night.
>Any replies to this message should be CC'ed directly to my e-mail
>account (nathan dot cline .. gmail dot com) as I am not currently
>subscribed to this list. I look forward to getting this patch of high
>enough quality to submit to Linus. Thanks!
>  
>
[PATCH SNIPPED]

Nathan you may also want to send a copy of your cleaned up patch to the 
folks at linuxconsole-dev@lists.sourceforge.net as that is list that 
deals with multihead development / issues. We also have patches for 
getting multiheaded X working as well.

Matt Keenan

