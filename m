Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269736AbTGZU6h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 16:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269711AbTGZU6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 16:58:37 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:61896 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S269736AbTGZU63
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 16:58:29 -0400
Message-ID: <3F22EFAD.4020207@pacbell.net>
Date: Sat, 26 Jul 2003 14:16:29 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz>
In-Reply-To: <20030726210123.GD266@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>>I'm not sure how the design is intended to work, but either way something 
>>>>needs to be fixed.
>>
>>Yes, it seems like all the HCDs (and the hub driver) need attention.
> 
> 
> Why the hub driver?
> 
> For basic functionality, you simply power it down (doing virtual
> unplug), and power it back up on resume (doing virtual plug of all
> devices). That should work reasonably for everything but mass-storage.

For non-basic functionality such as "remote wakeup", where you
can wake the system up from its suspension by doing things like
typing on the USB keyboard.


>>Plus, the enumeration process should respect hubs' power budgets,
>>and handle overcurrent better.  I had a hub re-enumerate over forty
>>times not that long ago, just because it enabled too many things at
>>once and the surge currents made lots of trouble.  Plenty of power,
>>if it got turned on carefully enough... :)
> 
> 
> Havin enough juice in "common case", but not in "worst case" is not
> too legal situation, is it?

This was a perfectly legal configuration, with what I recall as
four devices.  It was pretty far from "worst case".

- Dave


