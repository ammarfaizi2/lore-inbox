Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTJMQmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbTJMQmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:42:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:63361 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261968AbTJMQmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:42:49 -0400
Date: Mon, 13 Oct 2003 09:51:25 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: -test7: /sys/power/disk not reading right data?
In-Reply-To: <20031010091031.GA5018@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0310130946150.17450-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'm seeing this on -test7 (tainted:pavel, but I did not touch this
> > area).
> 
> Reproduced on -test7-bk, vanilla.

It's a known bug. If your system supports both S4 and S4bios, only the 
latter may be selected. 

> What advantages does disk/ state separation have? I believe that echo
> swsusp > state (or echo s4bios > state or echo disk-firmware > state)
> is the right interface, and that we want to do echo "s4bios" >
> on_battery_low or similar interface. (echo "mem" > on_battery_low
> makes sense, too, toshiba notebooks do that for example).

The string 's4bios' only makes sense on systems that support it, while 
'disk' is concise and obvious, regardless on how your platform implements 
it. I don't want to have options that are only relevant on a subset of the 
systems out there. 



	Pat

