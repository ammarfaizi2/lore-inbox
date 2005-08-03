Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVHCLl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVHCLl0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVHCLl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:41:26 -0400
Received: from mailserv.aei.mpg.de ([194.94.224.6]:41927 "EHLO
	mailserv.aei.mpg.de") by vger.kernel.org with ESMTP id S262071AbVHCLlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:41:24 -0400
Message-ID: <42F0AD60.3070201@freenet.de>
Date: Wed, 03 Aug 2005 13:41:20 +0200
From: Frank Loeffler <knarf.loeffler@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: de-de, de, en, en-us
MIME-Version: 1.0
To: mdew <some.nzguy@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [linux-usb-devel] Re: Fw: ati-remote strangeness from 2.6.12
 onwards
References: <20050730173253.693484a2.akpm@osdl.org>	 <1c1c8636050801220442d8351c@mail.gmail.com>	 <20050803055413.GB1399@elf.ucw.cz> <1c1c86360508030311486fc30a@mail.gmail.com>
In-Reply-To: <1c1c86360508030311486fc30a@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 'mdew' (you do have a name, do you?),

mdew wrote:
> mapped to "p". I found the TV Button, The DVD Button, the CH-/+ and
> the OK Button all non-working, every other button produced the "p".

Could you please try 'showkey -s' from a console on all of those keys?

Pavel: I would think that 'more useful' is not really the same as 
'correct'. If you find it useful to map this key to 'ENTER', so you 
should remap it in userspace. It should not be KEY_ENTER in the kernel 
for at least two reasons:

- The key is labled 'ok' (and not enter). I assume the code KEY_OK is
   made for exactly that kind of key and certain applications might
   look for exactly this code.
- You might want to differentiate between this key and the ENTER key
   of your keyboard, at least I do. If the kernel is sending the same
   code for both keys, this is not possible in userspace.

Frank

