Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286148AbRLaBv0>; Sun, 30 Dec 2001 20:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286147AbRLaBvQ>; Sun, 30 Dec 2001 20:51:16 -0500
Received: from mnh-1-18.mv.com ([207.22.10.50]:56333 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S286145AbRLaBvH>;
	Sun, 30 Dec 2001 20:51:07 -0500
Message-Id: <200112310311.WAA04875@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.54-2.4.17
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Dec 2001 22:11:24 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.17 is available.

It is now possible to attach UML consoles and serial lines to host ports,
allowing them to be accessed by telnetting to that port.  This also makes it
possible to access a UML from another machine without needing to put the UML
on the network.

Any number of devices can be attached to a port.  Telnets will be attached 
to them in some arbitrary order.  Excess telnets over devices will hang
until a device becomes available.

The context switching mechanism has been redone so that it's far simpler.  

UML can now be shut down by sending a SIGINT or SIGTERM to the tracing
thread, although this is somewhat buggy at the moment.

General purpose registers are now stored properly in core files. 

Some buffer overruns in uml_net, one which is definitely exploitable, were
fixed.  Thanks to Matt Zimmerman for spotting these.

Fixed various other bugs.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://user-mode-linux.sourceforge.net/dl-sf.html

				Jeff

