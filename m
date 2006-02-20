Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbWBTHI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbWBTHI4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 02:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWBTHI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 02:08:56 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:61848 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932677AbWBTHIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 02:08:55 -0500
Date: Mon, 20 Feb 2006 09:08:46 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Greg KH <gregkh@suse.de>
cc: Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
In-Reply-To: <20060220010205.GB22738@suse.de>
Message-ID: <Pine.LNX.4.58.0602200907160.15786@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> <20060217231444.GM4422@stusta.de>
 <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
 <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost>
 <20060220010205.GB22738@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2006, Greg KH wrote:
> That's _really_ odd, as hal, udev and dbus all work just fine on my
> machines with the above changeset (actually with 2.6.16-rc4).  And that
> changeset should not have caused anything to change with regards to the
> core uevent code, as it's a usb-serial change only.
> 
> And you don't even have CONFIG_USB_SERIAL enabled...  Very odd.
> 
> If you revert this one patch, on top of a clean 2.6.16-rc4, do things
> start working for you again?

Probably not. For some reason, I had udev and hal failing for plain 2.6.15 
too until I did make mrproper. So the bisect results are probably not 
reliable. I'll do that again this evening with mrproper. Uh.

			Pekka
