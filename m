Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279615AbRJ2X1L>; Mon, 29 Oct 2001 18:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279616AbRJ2X1B>; Mon, 29 Oct 2001 18:27:01 -0500
Received: from email1.byu.edu ([128.187.22.133]:19982 "EHLO email1.byu.edu")
	by vger.kernel.org with ESMTP id <S279615AbRJ2X0n> convert rfc822-to-8bit;
	Mon, 29 Oct 2001 18:26:43 -0500
Date: Mon, 29 Oct 2001 17:27:34 -0600
From: Josh Hansen <joshhansen@byu.edu>
Subject: Ease of hardware configuration
To: linux-kernel@vger.kernel.org
Message-id: <01KA2VPVO4QI9JEBL9@EMAIL1.BYU.EDU>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.6]
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,
Perhaps I'm beating a dead horse with this, but my belief is that the feature 
of greatest benefit to "Joe User" would be simplified hardware 
installation/configuration. A user coming from Windows who is used to being 
able to plug in a scanner, a mouse, a video card, whatever and having the OS 
tell him what it is and automatically set up drivers for him will have real 
trouble coming to Linux and having to compile a new kernel or new kernel 
module for a new piece of hardware.
	I am not familiar with the innards of the Linux Kernel, but here is my 
"vision" of what could be done to change this. The kernel already is able to 
detect what hardware is attached to the system's different buses generally 
speaking, so the next step is for it to identify which hardware already has 
drivers installed for it (built into the kernel or loaded modules). If no 
drivers are installed, a kernel message to the effect of "New Hardware 
Detected" could be issued. That is all the kernel has to do. The next steps 
are handled in userspace software.
	Some sort of daemon or cronjob mechanism can then monitor kernel messages 
until it finds the "New Hardware Detected" message. Then, a generic 
configuration utility is launched along with an appropriate frontend (simple, 
ncurses, GTK+, KDE, Motif, Tcl/Tk, whatever...) to allow the user to 
configure the device.
	Now here comes the radical part (ok, so all of this is somewhat radical): the 
configuration utility connects to a server such as linuxdevicedrivers.org or 
some other slick domain name and downloads the appropriate kernel module 
binaries for the hardware based on kernel version number and architecture 
(example: nVidia GeForce module for kernel 2.4.13 on i386, or USB Scanner 
module for kernel 2.4.4 on PowerPC). Once the module is obtained, it is 
loaded into the kernel (with explicit IO/IRQ parameters for older hardware if 
necessary).
	Once the module is loaded, the utility quits.
	The configuration utility could also allow for loading of modules from floppy 
disk or any other filesystem, or from another internet server.
	A working name for this utility and kernel message system could be "Linux 
Kernel Device Configurator".
	I expect that there will be many technical or other objections to such a 
system. I also expect to get ripped apart by at least a few hackers out 
there. However, that's great! I want input. I think this or a similar 
mechanism could really increase the ease of use for the "average user" and 
his nephew's godmother's granddaughter's roommate's dog, etc., etc.
	Thank you!
	- Josh Hansen


