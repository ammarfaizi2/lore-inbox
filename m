Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWBGDdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWBGDdi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWBGDdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:33:38 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:4858 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S964954AbWBGDdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:33:37 -0500
Message-ID: <43E8150E.9030801@comcast.net>
Date: Mon, 06 Feb 2006 22:33:34 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
CC: Andrew Morton <akpm@osdl.org>, alan@lxorguk.ukuu.org.uk,
       harald.dunkel@t-online.de, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion + tsc sync issues
References: <Pine.LNX.4.58.0601250846210.29859@shark.he.net> <43E3D103.70505@comcast.net> <Pine.LNX.4.58.0602060836520.1309@shark.he.net> <43E7A4C0.4020209@t-online.de> <1139255800.10437.51.camel@localhost.localdomain> <43E805D4.5010602@comcast.net> <43E7F73E.2070004@comcast.net> <43E7F73E.2070004@comcast.net> <20060206173520.43412664.akpm@osdl.org> <E1F6I3G-0003fw-00@chiark.greenend.org.uk>
In-Reply-To: <E1F6I3G-0003fw-00@chiark.greenend.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:

>Andrew Morton <akpm@osdl.org> wrote:
>
>  
>
>>That's bad.
>>    
>>
>
>Given that libata goes through the scsi layer at the moment, shifting
>from the traditional PATA drivers to the libata ones is going to result
>in a shift from hdfoo to sdbar. We're not really looking forward to this
>from the distribution point of view, though I think the same thing
>happened in the past when shifting from the ancient SATA drivers to the
>libata ones.
>
>  
>
Well, the badness mentioned above is the swapping of what gets loaded 
first from the testing branch to the upstream patches.   In mm, sata 
gets loaded before pata in libata land.  In alan cox's patches it's the 
reverse.  This results in different device names for the same config 
when switching between mm and release, which is bad, but is a problem 
that can be overcome with the use of labels instead of device names.

Perhaps from a distribution standpoint, moving to a label method of 
describing what gets mounted where would be best, rather than worrying 
about scsi naming schemes or ide ones.  Just think of the fun of a 
system with multiple usb storage devices and such.  
I'm just not sure if grub and the kernel "root=" parameter can handle it.

