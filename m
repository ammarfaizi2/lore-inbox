Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265864AbUAKNIR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 08:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbUAKNIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 08:08:17 -0500
Received: from 119.80-202-31.nextgentel.com ([80.202.31.119]:27081 "EHLO
	totto.homelinux.net") by vger.kernel.org with ESMTP id S265864AbUAKNIB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:08:01 -0500
Message-ID: <40014AE6.3070106@idi.ntnu.no>
Date: Sun, 11 Jan 2004 14:08:54 +0100
From: Tor Arvid Lund <tor.arvid.lund@idi.ntnu.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Keyboard problem in 2.6.1
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. Upgrading from 2.6.0 to 2.6.1 gave me the problem that my 
apostrophe/asterisk key didn't work (norwegian kbd layout, connected via 
USB). That is, I press the key, and nothing happens. The showkey program 
tells me this key has keycode 84.

So I check the patch file, and find that in the file:
   drivers/char/keyboard.c
and the section:
   static unsigned short x86_keycodes[256] =

the line:
- 80, 81, 82, 83, 43, 85, 86, 87, 88,115,119,120,121,375,123, 90,
                   ^^
was changed to:
+ 80, 81, 82, 83, 84, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
                   ^^
Now, I am nowhere near a kernel hacker, but I thought I'd try and change 
84 back to 43 (of course without any good reason other than "let's see 
what happens"), and it seemed to work.

I don't know what this means, but I thought maybe that some of you who 
actually _know_ a thing or two about the kernel could make something of 
all of this...

PS: please CC replies to <tor.arvid.lund at idi.ntnu.no>, as I am not 
subscribed to the list

Regards,
Tor Arvid
