Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUB1VWx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 16:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbUB1VWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 16:22:53 -0500
Received: from main.gmane.org ([80.91.224.249]:7850 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261918AbUB1VWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 16:22:49 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Mike <Mike@kordik.net>
Subject: Re: 2.6.3-bk9 QA testing: firewire good, USB printing dead
Date: Sat, 28 Feb 2004 16:22:45 -0500
Message-ID: <pan.2004.02.28.21.22.44.153321@kordik.net>
References: <1077933682.14653.23.camel@wave.gentoo.org> <20040228021040.GA14836@kroah.com> <1077937052.14653.40.camel@wave.gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: user-0c936ii.cable.mindspring.com
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 19:57:32 -0700, Daniel Robbins wrote:

> On Fri, 2004-02-27 at 19:10, Greg KH wrote:
>> Yes, I am.  Do you get any error messages in your syslog when the
>> printer hangs?
> 
> In some cases, I did. In other cases, I did not. Here are some "greatest
> hits... and I was also turning printers on and off and changing cables
> and testing different USB ports, so this first batch of log messages
> could correspond to those types of changes:
> 
>  Feb 27 10:52:11 [kernel] drivers/usb/class/usblp.c: usblp0: off-line
> Feb 27 10:52:44 [kernel] drivers/usb/class/usblp.c: usblp0: error -71
> reading printer status
>                 - Last output repeated 1140 times -
> Feb 27 10:52:45 [kernel] usb 1-4: USB disconnect, address 9 Feb 27
> 10:52:45 [kernel] drivers/usb/class/usblp.c: usblp0: error -71 reading
> printer status Feb 27 10:52:45 [kernel] drivers/usb/class/usblp.c:
> usblp0: removed
> 
> Then when I was doing my initial testing with the Epson Stylus Photo 960
> and the escputil program (as well as catting printer data directly to
> the printer,) I saw a bunch of stuff like this:
> 
> Feb 27 10:30:30 [kernel] usb 1-4.3: new full speed USB device using
> address 11 Feb 27 10:30:30 [kernel] ehci_hcd 0000:00:02.2: qh c1b91700
> (#0) state 1 Feb 27 10:30:30 [kernel] drivers/usb/class/usblp.c: usblp0:
> USB Bidirectional printer dev 11 if 0 alt 0 proto 2 vid 0x04B8 pid
> 0x0005 Feb 27 10:31:01 [kernel] drivers/usb/class/usblp.c: usblp0: on
> fire
> 
> Specific symptoms were not having the printers respond to an escputil
> (Epson printer utility from gimp-print) head cleaning run. On the laser
> printer, data would get to the printer, but seemingly slowly, and I'd
> need to hit the "go" button on the printer to get the sheet to print
> rather than have the printer print on its own. It seems that both
> printers did not get the full amount of data that they were expecting,
> and either didn't respond at all or didn't complete the print job
> without manual assistance.
> 
> The problems with the laser printer didn't generally produce any log
> messages. Those with the Epson (particularly escputil) generally did.
> 
> With 2.6.3-bk9, I also had a block of two mainboard USB ports simply
> stop functioning -- to the point of even no longer sending power to the
> USB hub that I was using.
> 
> Hope that helps and let me know if you need any more info,
> 
> Daniel

FYI these problems started for me about two weeks ago. I don't know what
event started it but I am running the Gentoo distro, with 2.6.3-mm2 (it
started these probs before 2.6.3-mm2), usb 1.1 OHCI with an Epson C80.
Print jobs would hang and I had to unplug my usb cable to clear the job. I
have reinstalled everything having to do with printing and I can now at
least print but it hangs on the last page. I have to turn the printer
off/on to continue. I assumed this was a cups issue but it sounds like a
usb issue with the kernel?

