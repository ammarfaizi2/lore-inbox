Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUJRWex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUJRWex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUJRWex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:34:53 -0400
Received: from [69.4.201.55] ([69.4.201.55]:47504 "EHLO bitworks.com")
	by vger.kernel.org with ESMTP id S267625AbUJRWeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:34:50 -0400
Message-ID: <41744505.4080507@bitworks.com>
Date: Mon, 18 Oct 2004 17:34:45 -0500
From: Richard Smith <rsmith@bitworks.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video
 card BOOT?
References: <200410160946.32644.adaplas@hotpop.com>	 <4173B865.26539.117B09BD@localhost> <417428F2.2050402@bitworks.com> <9e47339104101814166bf4cfe5@mail.gmail.com>
In-Reply-To: <9e47339104101814166bf4cfe5@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:

> Every system has to be able to somehow indicate that it can find/load the
> kernel image or that the image is corrupt or that hardware diagnostics failed.
> Displaying this info is the responsibility of the BIOS.
> 

Jon, I agree with you 100%.  I was merely responding to a statement I 
saw as false.

If we could get the video chip manufacturers to provide me with all the 
necessary documentation we embedded folk would be happy to do exactly as 
you say.  We could code up a nice robust boot time init procedure to 
serve our purposes.  OF would be great if all the mfgs would support it.

Its a sad fact though that we are (x86 anyway) dependant on some 
amazingly fragile, stupid, usually binary only, legacy bloated, and 
quite often buggy, 16-bit realmode video init code that should have been 
put to pasture many years ago.

LinuxBIOS has been trying to come up with a solution to the video BOOT 
problems for good while now.  Emulation seems to be the only thing that 
really has a chance of working.

I don't currently (see next paragraph) need the kernel to try and do all 
that stuff for me since I need it prior to when the kernel loads.  But 
what I would like is to be able to use/build on kernel framework without 
having to completely re-invent the wheel.

A long term goal of LinuxBIOS however is to use Linux _AS_ the bios 
which kind of nullifies your BIOS responsibility statement.  Some of the 
LANL clusters are doing this right now.  The only reason we aren't doing 
it 100% of the time is that a lot of motherboards don't have a big 
enough flash. Yet.  But with projects like linux-tiny and larger flashes 
headed our way those days are numbered.

Linux far exceeds the hardware support level and flexablity of any bios 
and already does 90% of the job a bios does anyway. In most cases better 
than the bios ever could.  Linux booting Linux is the ultimate 
bios/bootloader.

-- 
Richard A. Smith


