Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264623AbTFANkf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 09:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264624AbTFANkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 09:40:35 -0400
Received: from [62.75.136.201] ([62.75.136.201]:4228 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264623AbTFANka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 09:40:30 -0400
Message-ID: <3EDA052A.20807@g-house.de>
Date: Sun, 01 Jun 2003 15:52:42 +0200
From: Christian Kujau <evil@g-house.de>
Reply-To: evil@g-house.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: weird keyboard with 2.5.70
References: <3ED93A62.9080504@g-house.de> <20030601122903.GA18783@sexmachine.doom>
In-Reply-To: <20030601122903.GA18783@sexmachine.doom>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Kletschke schrieb:
> * Christian Kujau <evil@g-house.de> [Sun, Jun 01, 2003 at 01:27:30AM +0200]:
> 
>>hm, i guessed this was an important thing "in the old days" (TM),
>>i never had problems when "hotplugging" ps/2. nevertheless - i _have_ to
>>unplug/replug the ps/2 keyboard to actually _use_ it. after this is done
>>the keyboard is working right (and the mainboard, too :-))
> 
> Today I realize it more signifikant here. Sometimes a pressed key hangs,
> the kernel realizes not, that it was a single click. Then the Key is
> repeyted until I press it once again.

no, here it's more than "a single klick will write 5-10 chars". it is 
_not_ repeated to the infinite. and no, both kbds are OK (2.4.20-rc3 works)

> Christian, do you get this error only in X or at console too?

on X and console.

> 
> Furthermore my ps2 kbd is usable without hotplugging it, though.
> 
> The strange thing happens very often using ssh.

no, i don't think it's appliation related. to actuallay _use_ my system 
i have to login. and to do that, i will write my username / password. 
and to do that, i have to unplug/replug my keyboard.

since i have other module issues right now i'm on 2.4.20rc3 again. what 
i have done yesterday in the evening was this:
- i compiled 2.5.70 again, input/usb support statically include but with 
a modular  CONFIG_USB_KBD (usbkbd) and a modular CONFIG_KEYBOARD_ATKBD 
(atkbd). then i rebooted, logged in via remote console where i was able 
to load "atkbd" and "usbkbd". then both kbds were up *in a sane way* !!

so this would be the workaround for me.
i wonder when the problem will diesappear as it did on linux/alpha :-)

Thanks for comments,
Christian.


