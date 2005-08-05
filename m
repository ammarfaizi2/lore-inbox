Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbVHEGtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVHEGtA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVHEGqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:46:52 -0400
Received: from mailserv.aei.mpg.de ([194.94.224.6]:27312 "EHLO
	mailserv.aei.mpg.de") by vger.kernel.org with ESMTP id S262884AbVHEGqk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:46:40 -0400
Message-ID: <42F30B42.1020806@freenet.de>
Date: Fri, 05 Aug 2005 08:46:26 +0200
From: Frank Loeffler <knarf.loeffler@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: de-de, de, en, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Ryan Brown <some.nzguy@gmail.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, vojtech@suse.cz,
       dtor_core@ameritech.net
Subject: Re: [linux-usb-devel] Re: Fw: ati-remote strangeness from 2.6.12
 onwards
References: <20050730173253.693484a2.akpm@osdl.org>	<1c1c8636050801220442d8351c@mail.gmail.com>	<20050804101515.4a983b29.akpm@osdl.org>	<1c1c863605080415233c6aac0@mail.gmail.com> <20050804154442.7e739886.akpm@osdl.org>
In-Reply-To: <20050804154442.7e739886.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton wrote:
> IOW: what does this (wordwrapped!) patch do?

It changes the keycode the kernel is sending for three keys. For normal 
keyboards there is usually no argument to which keycode to send. An 'a' 
would send the keycoe for an 'a'. This however is a remote control. The 
keys are labled 'OK', 'TV' and 'DVD'. Therefore the kernel currently 
sends the keycodes KEY_OK, KEY_TV and KEY_DVD. The patch changes this to 
KEY_ENTER, KEY_PROG1 and KEY_PROG2.

I do not know about the motivation of this patch, as the kernel 
currently _does_ send keycodes, maybe just not the ones the some users 
might want. IMHO this is an issue of remapping the keycodes in userspace 
and I would like to leave the kernel-codes alone. However, I might not 
see the whole problem here because it is working fine for me.

Btw, Pavel:

 > No, I think that you can still diferentiate between them ... they come
 > from different keyboard after all. See /dev/input/event*.

How can I tell the consoles of linux which keyboard to use? So far they 
all use all keyboards (which is my usual keyboard mixed with the remote 
control keys). (Yes, I searched google extensivly and no, I do not have 
X on that machine.)

Frank

