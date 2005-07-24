Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVGXUFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVGXUFG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 16:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVGXUFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 16:05:06 -0400
Received: from 83-131-134-54.adsl.net.t-com.hr ([83.131.134.54]:3250 "EHLO
	mazuran.st") by vger.kernel.org with ESMTP id S261208AbVGXUFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 16:05:04 -0400
Message-ID: <42E3F474.90104@spymac.com>
Date: Sun, 24 Jul 2005 22:05:08 +0200
From: zhilla <zhilla@spymac.com>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050711)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Supermount
References: <42E00DD3.9060407@trn.iki.fi>
In-Reply-To: <42E00DD3.9060407@trn.iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well, for a bit of OT discussion sake, here's how it imho SHOULD work, 
from user (noobs and non guru) desktop point of view:
cd/dvds: mounted automatically on insert / first access. if a program is 
running from it (or a file is open from it), and user tries to eject it 
using button, or any eject-like software, kernel sends a signal to a 
central place. which is, for example, picked up from a window manager, 
or even X itself. which, in a friendly and non intrusive way, displays 
something like this: "drive hdc busy, please close the following 
processes first: 1. mplayer 2. blabla".
also, if a blank media is detected on access, it should not be mounted.
usb drives: similar. if user plugs it out without unmounting, its 
unmounted, and processes using files on it gracefully killed, or somehow 
"warned". how to "warn" them? ill let someonbe smarter think of the way 
:) and about ripping it out without closing, wm/anything should yell 
"bad user!! you should ALWAYS unmount first!"
floppys: i suggest leaving things 100% same. btw. i saw some distros 
having problem with accessing ie /mnt/floppy when there is no floppy 
present. bash goes wild with autocompletion. programs pause for a looong 
time. this could be a kernel bug.
other stuff: dont want to sound like troll, but i guess 98% of people 
dont use anything else.
system partitions: make a clear cut between folders which should be seen 
at all by anyone but root, kernel, special software. in other words: 
reduce clutter in / by hiding almost anything! and partition specific 
mount option such as
"userinvisiblefolder=/dev;/sys;/lib;/proc;/sys;/var"
should also be possible. face it, for regular user in varoius distros, / 
is to crowded.
i'm not saying this is all 100% correct or possible. couse this is, 
imho, greatest ugliness, user friendlyness and productivity reducer in 
linux. m$ has it a bit better in some ways, but crappier in other. any 
of these could be a killer feature for 2.8 kernel series. or 2.6.2x :)
i would like people to discuss this. be polite please :)
