Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751635AbWIFW0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbWIFW0p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWIFW0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:26:45 -0400
Received: from relay02.pair.com ([209.68.5.16]:63242 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751490AbWIFW0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:26:44 -0400
X-pair-Authenticated: 71.197.50.189
Date: Wed, 6 Sep 2006 17:22:13 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Pavel Machek <pavel@ucw.cz>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Takashi Iwai <tiwai@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, pshou@realtek.com.tw
Subject: Re: CodingStyle (was: Re: sound/pci/hda/intel_hda: small cleanups)
In-Reply-To: <20060906135140.GC11405@elf.ucw.cz>
Message-ID: <Pine.LNX.4.64.0609061716260.18840@turbotaz.ourhouse>
References: <20060831123706.GC3923@elf.ucw.cz> <s5h8xl52h52.wl%tiwai@suse.de>
 <20060831110436.995bdf93.rdunlap@xenotime.net> <20060902231509.GC13031@elf.ucw.cz>
 <20060902213046.dd9bf569.rdunlap@xenotime.net> <20060905080813.GE1958@elf.ucw.cz>
 <20060905084352.1ced999e.rdunlap@xenotime.net> <20060906135140.GC11405@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2006, Pavel Machek wrote:

> Hi!
>
>>> +comment out unused code.
>>> +
>>
>> Is there an acceptable way to leave source code in a file but
>> render it unused?  Like #if 0/#endif or #if BOGUS_SYMBOL/#endif ?
>
> I'd say "no way is acceptable, but #if 0/#endif is least evil" :-).

I'd say "no way is acceptable, but #if 0/#endif with proper comments is 
less evil."

Disabled code will never break if other parts of the code change 
without it; rather, it could just become plain wrong. People might either 
leave it alone (if they don't know what it is for) or try to change it (if 
they think they do).

If you must leave disabled code behind (which in my perfect world would be 
'never'), you should at least leave behind a comment explaining what the 
code is supposed to do and why it isn't enabled.

If it starts to drift from almost-functional to plain wrong, it becomes an 
even worse wart than it originally was.

Thanks,
Chase
