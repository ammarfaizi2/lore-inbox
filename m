Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbUANWW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbUANWW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:22:26 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:64780 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264126AbUANWWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:22:24 -0500
Date: Wed, 14 Jan 2004 23:22:14 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Ville Herva <vherva@twilight.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: Something corrupts raid5 disks slightly during reboot
Message-ID: <20040114222214.GA26930@alpha.home.local>
References: <20031031190829.GM4868@niksula.cs.hut.fi> <3FA30F4A.5030500@hundstad.net> <20031101082745.GF4640@niksula.cs.hut.fi> <20031101155604.GB530@alpha.home.local> <20031101182518.GL4640@niksula.cs.hut.fi> <20031101190114.GA936@alpha.home.local> <20040102194200.GA11115091@niksula.cs.hut.fi> <20040114144646.GS11115091@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114144646.GS11115091@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville,

On Wed, Jan 14, 2004 at 04:46:46PM +0200, Ville Herva wrote:
 
>   - I tried booting from 2.6.1 single user mode to 2.6.1 single user
>     mode (booting with sysrq-b to avoid shutdown process):
>        ->  The corruption on /dev/hdg happens like with 2.2 and 2.4
> 
>   - I booted from 2.6.1 single user mode to 2.6.1 single user
>     mode with kexec patch to avoid entering BIOS in between
>        ->  The corruption DOES NOT happen
> 
> I'm pretty much out of ideas.

To me, it proves that the bios triggers the problem. It could also be in
the device enumeration functions or device initialization that it does
this thing. Perhaps even a more nasty thing such as a pending DMA write
which completes during a device reset. That's very odd anyway. I don't
quite remember well all your setup. Have you tried enabling/disabling
shadow ram/caching on bios regions to check if a faster/slower code execution
in the bios changes something ? Also do it on additionnal ROMs if you have
an onboard bios on your secondary controller.

I'm also getting stuck without any other idea :-/

Regards,
Willy

