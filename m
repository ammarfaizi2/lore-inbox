Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267134AbUBMRj5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 12:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267139AbUBMRj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 12:39:57 -0500
Received: from mail.gmx.de ([213.165.64.20]:22502 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267134AbUBMRjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 12:39:53 -0500
X-Authenticated: #420190
Message-ID: <402D0C3A.6070909@gmx.net>
Date: Fri, 13 Feb 2004 18:41:14 +0100
From: Marko Macek <Marko.Macek@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Robert White <rwhite@casabyte.com>, linux-kernel@vger.kernel.org
Subject: Re: ps/2 mouse problem with KVM switch
References: <402602B9.1090005@gmx.net> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAIH4lUMJJWUqlFPWIv65Y6gEAAAAA@casabyte.com> <20040213081231.GA247@ucw.cz>
In-Reply-To: <20040213081231.GA247@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> Sadly enough, there is a soft reset command in the PS/2 protocol, and
> the PS/2 interface is designed for hotplug, and because of that Linux
> 2.6 can easily handle hotplugging of both PS/2 keyboards and mice,
> including type detection, etc, BUT the KVM switches don't use that,
> because Windows historically doesn't support unplugging a PS/2 mouse.

If the mouse gets into confusing state, I can "replug" it into the KVM 
switch (while in Windows) and it works fine after that. I have also 
noticed that when Windows is doing "resume" I must not switch away 
before it is if I want my mouse to work (otherwise I will need to replug).

For Linux, I also need to switch from X to console and back when the 
mouse is "confused".

With 2.4 I repeat the the 2 steps described above my mouse works (incl 
wheel) on both machines after that.

> The most ugly part of the KVM switch in this play is that while the KVM
> switch usually implements a virtual mouse for each of the machines, it
> lets them all talk to the real one, and if they have different ideas
> about what mode the mouse should be set to, well, then there goes the
> road to madness.

I guess I need to figure out how to force both machines to initialize 
the mouse in the same way then...

Regards,
Mark


