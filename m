Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268300AbUH2ULr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268300AbUH2ULr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268299AbUH2ULr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:11:47 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:64710 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268292AbUH2ULm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:11:42 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <41323751.5000607@namesys.com>
Date: Sun, 29 Aug 2004 13:06:41 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: flx@msu.ru, Paul Jackson <pj@sgi.com>, riel@redhat.com, ninja@slaphack.com,
       torvalds@osdl.org, diegocg@teleline.es, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com> <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com> <20040829150231.GE9471@alias> <4132205A.9080505@namesys.com> <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk> <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Sun, Aug 29, 2004 at 07:36:29PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
>  
>
>>>he wants without recompiling to do it.  This kind of a view requires no 
>>>coding because you can just mount the root filesystem two ways, one with 
>>>the -nopseudos mount option, and one without it.
>>>      
>>>
>>*What*?
>>
>>OK, now I want detailed explanation of the reasons why that doesn't create
>>cache coherency problems.
>>
>>Do you have an analysis of locking in the entire thing?
>>    
>>
>
>And I am very, very serious about that - we are talking about very nasty
>minefield and design choices in that area have fundamental impact on the
>entire layer, wherever it is located.
>
>It's *NOT* something that you can leave until later and hope it somehow
>falls into place - it can be merged in steps, but you MUST know the goal
>on that level.  To rearchitect later might be possible (even though you
>will a hell of a time avoiding plugins breakage), but it will be *hard*.
>
>
>  
>
How about if you educate me on the problems you see for a bit before I 
respond? I think it might help us move into a constructive discussion.

You are more experienced with your code than I am.... but I firmly 
believe that having different views of the same filesystem in which some 
files are visible in one view but not in another is technically feasible 
for some VFS, though I'd like to learn about the problems you see for 
doing it in the current VFS.
