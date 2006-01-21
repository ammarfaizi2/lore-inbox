Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWAUJXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWAUJXA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 04:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWAUJXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 04:23:00 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:48795 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750735AbWAUJW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 04:22:59 -0500
Date: Sat, 21 Jan 2006 10:22:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michael Loftis <mloftis@wgops.com>
cc: Jesper Juhl <jesper.juhl@gmail.com>, dtor_core@ameritech.net,
       James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
In-Reply-To: <0FA349BF620394796EB40A3A@d216-220-25-20.dynip.modwest.com>
Message-ID: <Pine.LNX.4.61.0601211017400.21704@yvahk01.tjqt.qr>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> 
 <43D10FF8.8090805@superbug.co.uk>  <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
  <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com> 
 <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com>
 <9a8748490601201220h2d85fa4au780715ff287cf1eb@mail.gmail.com>
 <0FA349BF620394796EB40A3A@d216-220-25-20.dynip.modwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'd say the kernel tries damn hard at maintaining backwards
>> compatibility for userspace.
>> It tries less hard, but still makes a pretty good effort, for internal
>> APIs, but the real solution to the internal API churn is to get your
>> code merged as it'll then get updated automagically whenever something
>> changes - people who remove or change internals try very hard to also
>> update all (in-tree) users of the old stuff - take a look at when I
>> removed a small thing like verify_area() if you want an example.
>
> The only argument I have is one that won't fly at all here on LKML and that's
> about all the corporate sponsors the LK has that are also doing custom closed
> source modules that are only useful for their particular hardware.

It really does not fly. I run a "damn old" nvidia driver (1.0-4496)
with a little portforward work on a 2.6.15. It is slowly ceasing to
be perfect, but given that 4496 was originally only for 2.4, I'd say
that's good news. (It was first portforwarded by sh.nu to 2.6.4 or so,
until nvidia.com came up with 2.6 support on their own. I then took
the sh.nu port and pf'ed it on my own, and until now, the only things
that make slight gcc warnings are CONFIG_PM_LEGACY and the 4-level-pagetable
stuff. I'd say the API is stable long enough!)


Jan Engelhardt
-- 
