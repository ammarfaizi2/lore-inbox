Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbUAGC1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 21:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUAGC1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 21:27:48 -0500
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:59336 "HELO
	develer.com") by vger.kernel.org with SMTP id S266114AbUAGC1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 21:27:46 -0500
Message-ID: <3FFB6E9E.6040500@develer.com>
Date: Wed, 07 Jan 2004 03:27:42 +0100
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Fredrik Olausson <fredrik@olaussons.net>
CC: lkml <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: bad scancode for USB keyboard
References: <3FF6EFE0.9030109@develer.com> <3FFB6A5D.9030606@olaussons.net>
In-Reply-To: <3FFB6A5D.9030606@olaussons.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fredrik Olausson wrote:

(I've re-posted to lkml in case someone else finds it useful)

> Bernardo Innocenti wrote:
>> I have a USB keyboard (Logitech Internet Navigator).
>> This keyboard has two "backslash + bar" keys, one of which
>> is located next to the RETURN key.
>>
>> The backslash key always worked fine in 2.4.x, but in 2.6.x
>> and 2.6.0, the scancode reported by showkey is "84", which is
>> usually associated with the "Prevconsole" function in most
>> keymaps.
>>
>> Editing the keymap fixes the problem, but of course this must
>> be a bug in the kernel driver.  I compared the 2.4.23 version
>> of kbdmap.c with 2.6.0, but didn't find any obvious reason for
>> this difference.
>
> I have the same problem with a Logitech cordless desktop.
> I can easily change the keycode to generate the right characters when in 
> console-mode, but XFree gives that key and the Print Screen key the same 
> keycode.
> After changing the xmodmap I can get the unmodified character, 
> but modifiers doesn't work, it just gives me the same character not 
> matter what modifier I use (shift, alt, alt_gr etc.)

I had fixed my console keymap too, but I've not been able to
figure out how to change the X keymap.  I've been looking in
the /usr/X11R6/lib/X11/xkb/ directory, but perhaps XKB is not
being used for old-style keyboard mapping?

Could you provide detailed instructions?  C coding with missing
backslash and bar keys is quite hard :-)

Of course, I still thing its' a 2.6 kernel bug and it should be
fixed.  Vojtech, do you have an idea why it's happening?

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/


