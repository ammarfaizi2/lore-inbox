Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbSJ1Rrv>; Mon, 28 Oct 2002 12:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261423AbSJ1RrW>; Mon, 28 Oct 2002 12:47:22 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:63371 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261401AbSJ1RbS>;
	Mon, 28 Oct 2002 12:31:18 -0500
Date: Mon, 28 Oct 2002 18:34:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Grimm <jgrimm2@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: 2.5.44: Still has KVM + Mouse issues
Message-ID: <20021028183419.A32183@ucw.cz>
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

The workaround is to use "psmouse_noext" command line parameter in case
you use a KVM switch that cannot properly handle the extended protocols.

-- 
Vojtech Pavlik
SuSE Labs
