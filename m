Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbTL1Edp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 23:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbTL1Edp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 23:33:45 -0500
Received: from mail.eskimo.com ([204.122.16.4]:26642 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id S264940AbTL1Edo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 23:33:44 -0500
Date: Sat, 27 Dec 2003 20:33:24 -0800
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: Joshua Schmidlkofer <kernel@pacrimopen.com>,
       "David B. Stevens" <dsteven3@maine.rr.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Jos Hulzink <josh@stack.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 (future kernel) wish
Message-ID: <20031228043324.GA1341@eskimo.com>
References: <200312232342.17532.josh@stack.nl> <20031226233855.GA476@hh.idb.hist.no> <3FECCAF9.7070209@maine.rr.com> <1072507896.27022.226.camel@menion.home> <3FEE47F5.6090406@why.dont.jablowme.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FEE47F5.6090406@why.dont.jablowme.net>
User-Agent: Mutt/1.5.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 27, 2003 at 10:03:17PM -0500, Jim Crilly wrote:
> >
> Generally it just complains that you pulled out the device prematurely, 
> I've never seen one give a STOP error from that but I guess a bad driver 
> or USB controller could cause anything.
> 
> When you insert a device like a USB stick Windows puts a little icon 
> next to the clock in the system tray that you're supposed to use to stop 
> the device before pulling it, effectively it unmounts and stops (or 
> atleast releases the device from) the driver so the device can be 
> 'safely' removed. I also believe Windows mounts any removable device 
> synchronously so that if you do pull it out prematurely the damage done 
> is limited.

I think the behavior of Win2k and WinXP is different for removable
devices.  Win2k seems to use async writes, and complains a lot if you
remove them without stopping.  XP seems to use sync writes, and doesn't
tend to complain much.

I haven't seen either one crash from pulling out flash cards from a card
reader (haven't tried a pen drive or similar).  However, the media
drivers they use for the USB readers sometimes seem to get into a bad
state where they're continually writing until you unplug the device.

-J
