Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVCVDiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVCVDiq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbVCVDbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 22:31:20 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:1174 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S262518AbVCVCfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:35:08 -0500
Date: Mon, 21 Mar 2005 21:35:06 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime, now 2.6.12-rc1-mm1
In-reply-to: <20050321153728.2f239b49.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503212135.07063.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200503082326.28737.gene.heskett@verizon.net>
 <20050321153728.2f239b49.akpm@osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 18:37, Andrew Morton wrote:
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> 2.6.11-mm2 seems to work, mostly.
>
>If you've tested 2.6.12-rc1-mm1 can you please send an update on
> your woes to linux-kernel?

Ok, got it built ok, but the reboot was hell, not of your doing 
though.  Someone had told me I could put a '-V' in a file 
called /fsckoptions and I'd get a bit more verbosity out of e2fsck.

I thought that might be a good thing and put an echo statement in my 
rc.local to regenerate that file.  Yup, attack of dumbass. I'd used 
the esc sequence to put an EOL on it, but that translated to a file 
containing '-V\n' which wasn't legal, so after looping around thru 
the reboot and dropping you to a shell thingies, and finding that I 
couldn't remount it rw under any circumstances I grabbed the rescue 
cd and got rid of all that.  So I'm just now rebooted to it.  So far 
it feels pretty good.

tvtime works, no audio glitches in the startup.  This is a pcHDTV-3000 
card, running in Never Twice Same Color mode as yet.

xsane works normally I believe, doing a preview scan ok.

kino works, but doesn't really want to time share with the much cpu 
hungrier tvtime, this results a very noticeable lag in the preview 
video coming in directly from the cameras imager via firewire, and 
sometimes an outright freeze of 2-3 seconds duration when kmail is 
makeing a mail fetch run.

spcagui works once I'd reinstalled the spca50x stuff

/. pops right up in mozilla-1.7.5, also in firefox

Those seem to be the main things of interest right now, to me.  

Anything else I should specifically check on this UP machine?

As I add content to this message, I am occasionally seeing lags 
between what I type and its showing up on the screen but its 
certainly better than 2.6.10 or 11 was by quite a ways.  This is 
related to the kino lags in that I believe its kmail's net access 
that is causeing them.

Overall, I don't have any instant squawks Andrew.  Looks good, 
generally feels good.  Itches might develop later though.  I'm using 
the cfq scheduler, were there any changes of note there?

-- 
Cheers Andrew & list, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
