Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266294AbUGES2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266294AbUGES2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 14:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUGES2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 14:28:22 -0400
Received: from netrider.rowland.org ([192.131.102.5]:7684 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S266294AbUGES2V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 14:28:21 -0400
Date: Mon, 5 Jul 2004 14:28:20 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: janne <sniff@xxx.ath.cx>
cc: Duncan Sands <baldrick@free.fr>, <linux-usb-users@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.6.7, usb2 data corruption & lockups & poor performance
In-Reply-To: <Pine.LNX.4.40.0407050318490.20551-200000@xxx.xxx>
Message-ID: <Pine.LNX.4.44L0.0407051424290.15781-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2004, janne wrote:

> Updated kernel to 2.6.7, apparently bttv and pci overloading are not
> issues here: I got usb2 to crash with nothing else loading the pci bus
> except light network traffic. usb2 read speed improved from 5-15MBytes/s
> to over 20MBytes/s when i switched it to a kt600 motherboard.
> But still it's over 10MBytes/s less than the manufacturer's claimed
> sustained data rate.

Why do you say that you got usb2 to crash?  The log you posted clearly 
shows that the crash originated in the reiserfs code, caused by a series 
of I/O errors.

Your log doesn't give any indication why those I/O errors occurred; in 
fact it starts in the middle of the errors.  If you want to find out what 
really went wrong, you will have to turn on the usb-storage debugging 
option in your kernel's configuration.

Alan Stern

