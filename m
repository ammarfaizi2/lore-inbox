Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWAXUy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWAXUy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 15:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWAXUyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 15:54:55 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:34998 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750822AbWAXUyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 15:54:55 -0500
Date: Tue, 24 Jan 2006 21:54:52 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Lee Revell <rlrevell@joe-job.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060124181813.GA30863@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.61.0601242151520.17164@yvahk01.tjqt.qr>
References: <1138014312.2977.37.camel@laptopd505.fenrus.org>
 <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner>
 <1138048255.21481.15.camel@mindpipe> <20060123212119.GI1820@merlin.emma.line.org>
 <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
 <20060124181813.GA30863@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> SUSE currently does it in A Nice Way: setfacl'ing the devices to include 
>> read access for currently logged-in users. (Well, if someone logs on tty1 
>> after you, you're screwed anyway - he could have just ejected the cd when 
>> he's physically at the box.)
>
>There are some things to complicate matters. SUSE patch subfs into the
>kernel and ship the needed user-space, think of this as quick
>automounter. It releases the drive and unmounts the medium when the last
>file is closed. In older SUSE releases, tty? logins didn't trigger
>such access controls, only "desktop" logins through kdm or gdm.

I think this is independent of subfs. This is, afaicg, a resmgrd thing. And 
since I do not use [a-z]dm, but tty login + startx, well, you can 
guess.

>> Yes, the device numbering is not optimal. (I already hear someone saying 
>> 'have udev make some sweety symlink in /dev'.)
>> But in case of /dev/hd*, we are pretty sure of what device is connected 
>> where. In case of sd*, it's AFAICS not - the next device plugged in gets 
>> the next free sd slot.
>
>What matters is sg, and perhaps sr.

Where is the difference between SG_IO-on-hdx and sg0?



Jan Engelhardt
-- 
