Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281027AbRKYUXN>; Sun, 25 Nov 2001 15:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281031AbRKYUXD>; Sun, 25 Nov 2001 15:23:03 -0500
Received: from mnh-1-22.mv.com ([207.22.10.54]:50955 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S281027AbRKYUWr>;
	Sun, 25 Nov 2001 15:22:47 -0500
Message-Id: <200111252142.QAA03352@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.52-2.4.15
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 25 Nov 2001 16:42:05 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.15 is available.

The mconsole protocol is now structured, rather than being plain text. You
will need the new mconsole client in order to do mconsole things with this
kernel.  

Improved the error message that gets printed when there are no
multcast-capable interfaces on the host.  

It is now possible to write to a COW-ed device that contains a non-root
filesystem.  

The errors that get spit out from uml_net when you remove a net device are
gone.  

Compilation warnings were fixed, and various bit of code were cleaned up. 

The network backends now pass the netmask to uml_net so it can do proxy
arp properly.  You will need the latest utilities in order to run this.  

There is support for RT signals in the form of a siginfo struct on the
stack if necessary.  There is no ucontext on the stack as yet.  

Fixed a bug which could cause a hang with a process receiving infinite
segfaults.  

Fixed a bug in sigsuspend and rt_sigsuspend which caused them to return
incorrect values.  

Fixed the tuntap packet dropping problem, fixed the same bug in all the
other transports, and merged all the read routines.  

In the utilities:

Updated uml_mconsole to use the new protocol. 

Proxy arp is now smart enough to only add arp entries to interfaces which
are on the local network.   

Slip now supports changing IP addresses. 

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://user-mode-linux.sourceforge.net/dl-sf.html

				Jeff

