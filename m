Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbVLKMMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVLKMMh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 07:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVLKMMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 07:12:37 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:4770 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1751345AbVLKMMh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 07:12:37 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: dtor_core@ameritech.net
Subject: Re: [git pull 02/14] Add Wistron driver
Date: Sun, 11 Dec 2005 13:10:13 +0000
User-Agent: KMail/1.9
Cc: "Yu, Luming" <luming.yu@intel.com>, Linus Torvalds <torvalds@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
References: <3ACA40606221794F80A5670F0AF15F840A53FCC5@pdsmsx403> <d120d5000512060721j3a75ff7bh40309f4fa132b39a@mail.gmail.com>
In-Reply-To: <d120d5000512060721j3a75ff7bh40309f4fa132b39a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111310.14984.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 December 2005 15:21, Dmitry Torokhov wrote:

Hi, sorry for the delay, just returning from Spain...

> > There are acpi daemon for any evetnts that needs user space attention.
> > I'm not sure if these events should be routed to input layer.
>
> How do you suggest handle buttons such as "Mail", "WWW", etc? Through
> acpid? And then tunnel them to X somewhow?

I think routing them to the input layer makes most sense because they are keys 
like everything else -- of course hacking acpid to pass on ACPI key events to 
Xorg via the XTest extension is not exactly hard, but that would break the 
keys in text mode (who knows, maybe someone wants to map his mail key to 
"mutt[RETURN]"?), and of course launching an application from acpid is a bit 
hard (acpid runs as root --> need to figure out which user is pressed the 
button, switch user IDs, find the correct X display if any, .....) if it's an 
input event, solutions for the expected functionality already exist - e.g. 
khotkeys.

> > With acpi enabled - wistron module, bluetooth works.
> > From these test cases, do you still think wistron driver can help my
> > laptop?
>
> No, you have proven that the driver will not help to your laptop. Now,
> as it is, it won't even load on your laptop either, because of
> different DMI signature. So why are you complaining? I am pretty sure
> Bernhard (who added bluetooth handling) has his working with ACPI.
> Bernhard, any input on this?

I have ACPI + wistron module. Can't tell if bluetooth actually works because I 
don't have any bluetooth hardware, but I can tell the bluetooth LED can be 
turned on and off.

ACPI works on this box, but not the ACPI buttons stuff (guess they aren't 
following standards...). I'm running a modified 2.6.15-rc5-mm1 here (none of 
the modifications touch ACPI though).
