Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbVJNS0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbVJNS0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVJNS0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:26:16 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:20140 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750840AbVJNS0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:26:14 -0400
Date: Fri, 14 Oct 2005 20:26:13 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@suse.cz>, Jeff Mahoney <jeffm@suse.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
In-Reply-To: <20051014165223.GA23420@mail.shareable.org>
Message-ID: <Pine.LNX.4.62.0510142014430.19927@artax.karlin.mff.cuni.cz>
References: <20051010214605.GA11427@br.ibm.com>
 <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz>
 <1129017155.12336.4.camel@imp.csi.cam.ac.uk> <434D6932.1040703@suse.com>
 <Pine.LNX.4.62.0510122155390.9881@artax.karlin.mff.cuni.cz> <434D6CFA.4080802@suse.com>
 <Pine.LNX.4.62.0510122208210.11573@artax.karlin.mff.cuni.cz>
 <20051013111707.GB516@openzaurus.ucw.cz> <20051014165223.GA23420@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Oct 2005, Jamie Lokier wrote:

> Pavel Machek wrote:
>
>> and/or make dirty data hdd based (not ram based)
>
> Ooh, swappable dirty data... nice idea :)

Multics had something like this :-) They had fast small drum and slow big 
disk --- so they wrote dirty file pages first to drum and then moved them 
to disk. Needless to say that it very too complex and they ripped it out 
of the system after years.

http://www.multicians.org/mgp.html#pagemultilevel

Mikulas

>> and/or restricting dirty buffers to 10MB for removable media.
>
> That seems like the simplest effective solution.
>
> -- Jamie
>
