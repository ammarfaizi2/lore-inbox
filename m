Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbTAZNEm>; Sun, 26 Jan 2003 08:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbTAZNEm>; Sun, 26 Jan 2003 08:04:42 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:2798 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266876AbTAZNEl>;
	Sun, 26 Jan 2003 08:04:41 -0500
Date: Sun, 26 Jan 2003 14:13:37 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Grimm <jgrimm2@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44: Still has KVM + Mouse issues
Message-ID: <20030126141337.J31427@ucw.cz>
References: <3DB9DA64.E48C8C5B@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DB9DA64.E48C8C5B@us.ibm.com>; from jgrimm2@us.ibm.com on Fri, Oct 25, 2002 at 06:57:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 06:57:24PM -0500, Jon Grimm wrote:
> Hello,
> 	I see that Thomas Molina 2.5 problem list no longer carries a KVM and
> mouse 
> issue where it previously had.  
> 
> 	If a fix is available I'd love to test it out as I still see strange
> behavior 
> with an Intellimouse and my MasterView CS-104 KVM switch (yep its
> old).   
> 
> 	With a few trusty printks, it looks like after I switch away & back 
> into 2.5.44, the mouse is now sending 3 byte packets instead of the 4 it 
> previously was.  
> 
> 	As you can imagine this causes all sorts of havok as the packets are 
> interpretted completely wrong from there on out.  If there is enough
> delay between 
> events, the synchonization logic kicks in and throws the packet out,
> since 
> it thinks the 4th byte is old (where it is really the first byte of the
> next 
> 3-byte packet).   This generates those pesky "psmouse.c: Lost
> synchronization "..  
> However, much of the time an incorrect 4-byte frame gets interpretted
> and 
> the X going totally haywire.    
> 
> BTW, serio_rescan() gets the mouse back into a happy 4-byte generating 
> state.     

Use the psmouse_noext option.

-- 
Vojtech Pavlik
SuSE Labs
