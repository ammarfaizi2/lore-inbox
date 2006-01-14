Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWANVhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWANVhu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 16:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWANVhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 16:37:50 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:13775 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751297AbWANVhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 16:37:50 -0500
Date: Sat, 14 Jan 2006 22:37:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeffrey Mahoney <jeffm@suse.com>
cc: Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs mount time
In-Reply-To: <43C961D2.90303@suse.com>
Message-ID: <Pine.LNX.4.61.0601142235200.23423@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0601082320520.2801@yvahk01.tjqt.qr>
 <20060114203410.GB21901@atrey.karlin.mff.cuni.cz> <43C961D2.90303@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>brought to attentino on an irc channel, reiser seems to have the largest 
>>>mount times for big partitions. I see this behavior on at least two 
>>>machines (160G, 250G) and one specially-crafted virtual machine
>>>(a 1.9TB disk / 1.9TB partition - took somewhere over 120 seconds).
>>>Here's a dig http://linuxgazette.net/122/misc/piszcz/group001/image002.png 
>>>from http://linuxgazette.net/122/TWDT.html#piszcz
>>>So, any hint from the reiserfs developers how come reiserfs takes so long?
>>>Standard mkreiserfs options (none extra passed).
>> 
>>   If I remember correctly, the problem is reiserfs loads bitmaps on mount
>> and that takes most of the time. Jeff Mahoney <jeffm@suse.com> has
>> patches fixing this but I think Hans rejected them because he wants only
>> bugfixes in reiser3...
>
>Yeah, that's the right analysis. ReiserFS caches bitmaps on mount and
>for large file systems it can take a quite a long time.

And quite some memory. But never mind, I already migrated by now.
(Not because of mount time, but other factors.)



Jan Engelhardt
-- 
