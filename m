Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUDKPrP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 11:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUDKPrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 11:47:15 -0400
Received: from netrider.rowland.org ([192.131.102.5]:5127 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S262370AbUDKPrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 11:47:14 -0400
Date: Sun, 11 Apr 2004 11:47:13 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <usb-storage@lists.one-eyed-alien.net>
Subject: Re: Patch for usb-storage in 2.4   [linux-usb-devel]
In-Reply-To: <20040410183638.5b177147.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.44L0.0404111144500.12891-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Apr 2004, Pete Zaitcev wrote:

> On Sat, 10 Apr 2004 17:09:57 -0700
> Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
> 
> > Was there a reason to add more do-nothing code to host_reset?
> 
> Woopsie. I wanted to write it, but understood that if I return right
> code from "bus" reset, it should never be called. Sorry about that...
> I'll remove that part.

I haven't had time to look at your patch in any detail yet.  But I did 
notice the extra stuff in the host-reset path.  It looks like you're 
worrying about nothing -- the easiest thing to do would be to remove the 
host-reset pointer from the host template.  Then the SCSI error handler 
would know that host resets aren't implemented and would never try to 
carry them out.

Alan Stern

