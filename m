Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVGJUqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVGJUqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVGJUoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 16:44:08 -0400
Received: from mx1.rowland.org ([192.131.102.7]:22034 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S262117AbVGJUmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 16:42:31 -0400
Date: Sun, 10 Jul 2005 16:42:26 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Parag Warudkar <kernel-stuff@comcast.net>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.12 - USB Mouse not detected
In-Reply-To: <200507100936.23705.kernel-stuff@comcast.net>
Message-ID: <Pine.LNX.4.44L0.0507101638470.24579-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jul 2005, Parag Warudkar wrote:

> Beginning 2.6.12 my Wireless USB Mouse is not detected in the first attempt - 
> Meaning if I boot the machine with the mouse connected, it's not detected 
> until I disconnect the mouse and then reconnect it.

That's not quite right.  Your log clearly shows the mouse was detected and 
assigned address 2.

>  It works fine after the disconnect-reconnect cycle. Looking at the
> dmesg, it seems that at first time it forgets to register the hiddev
> driver - mysteriously, it remembers the second time.

Exactly.  The hiddev driver wasn't loaded the first time, which makes this 
sound like some sort of hotplug failure.  Are your hotplug and udev 
packages up to date?

Alan Stern

