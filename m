Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278788AbRJ3IFo>; Tue, 30 Oct 2001 03:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276032AbRJ3IFe>; Tue, 30 Oct 2001 03:05:34 -0500
Received: from femail40.sdc1.sfba.home.com ([24.254.60.34]:14730 "EHLO
	femail40.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S278788AbRJ3IFV>; Tue, 30 Oct 2001 03:05:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Josh Hansen <joshhansen@byu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Ease of hardware configuration
Date: Mon, 29 Oct 2001 22:27:07 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <01KA2VPVO4QI9JEBL9@EMAIL1.BYU.EDU>
In-Reply-To: <01KA2VPVO4QI9JEBL9@EMAIL1.BYU.EDU>
MIME-Version: 1.0
Message-Id: <0110292127070I.05062@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 October 2001 18:27, Josh Hansen wrote:

> 	A working name for this utility and kernel message system could be "Linux
> Kernel Device Configurator".

Or, on redhat, you could call it "kudzu".  (Type "man kudzu".)  I first 
noticed it in the boot sequence during...  6.2?  Might have been there 
earlier...

Now true hotplug is a seperate issue.  Kudzu runs at boot time (or when you 
type it in from the command line) and detects network cards and mice and 
stuff.  You can't hotplug PCI.  (Well, you can, but not if you expect it to 
WORK.  Or if you don't want to replace burned out pieces of hardware.)  
Generally, for hotpluggable bus types, we have a daemon.  There's one for 
pcmcia/cardbus devices, for example.  I'm guessing there's something for USB 
(I don't use it).  All of this is sort of getting not-exactly integrated into 
devfs, which also has a userspace daemon and does automatic device detection.

Auto-detecting oddball peripherals connected to serial and paralell ports 
(mice and printers) is a problem for things like XFree86 or the print spooler 
that actually uses them.  (And if you run kudzu it'll get those too, it just 
doesn't know WHEN to run because they don't generate a hotplug interrupt when 
they get changed.)  Again, a user space issue. 

As for downloading fresh drivers newer than your distribution (ala debian's 
apt-get), that's tangled up in binary compatability issues between module 
versions.  Installing modules for just about every single supported driver 
takes up...  ("du /lib/modules/2.4.2-2"...) 22 megabytes.  I have PDF files 
larger than that.  (If you want to start a binary module compatability 
flamewar, feel free, but it's an ooooooooold issue steeped in politics.)

As for replacing the entire kernel without the user prompting...  That's just 
plain dangerous.  (Especially aimed at users who dunno what to do when things 
go wrong.  And I'm not just talking about 2.4.11...)

> 	I expect that there will be many technical or other objections to such a
> system.

Such as the fact it's pretty much already been implemented by distribution 
vendors, and is not really a kernel issue at all but a user space issue?

 I also expect to get ripped apart by at least a few hackers out
> there. However, that's great! I want input. I think this or a similar
> mechanism could really increase the ease of use for the "average user" and
> his nephew's godmother's granddaughter's roommate's dog, etc., etc.

Have you tried Red Hat 7.2, with the KDE desktop?  My cat HAS tried to use 
it.  (Sphynx sent an email I wasn't finished typing.  Sat right in my lap, 
reached out and pressed the mouse button.  Kind of impolite, I thought.  Then 
again she's a lap cat, which means my laptop and her body compete for the 
same ecological niche...)

> 	Thank you!
> 	- Josh Hansen

There's an old saying on usenet.  If you want answers, don't ask questions.  
Post errors.  It works for me.

Rob
