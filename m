Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUCaQRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbUCaQRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:17:00 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:5018 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262050AbUCaQQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:16:55 -0500
Date: Wed, 31 Mar 2004 08:17:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: seriel console support broken in -mm4 and -mm5
Message-ID: <37860000.1080749822@[10.10.2.4]>
In-Reply-To: <20040329112856.0b103c66.akpm@osdl.org>
References: <189440000.1080583215@[10.10.2.4]><190920000.1080584708@[10.10.2.4]> <20040329112856.0b103c66.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > It works fine in -rc2.
>> > 
>> > -mm4 prints jibberish (wrong speed / settings?) for serial console, but
>> > the getty stuff comes out file. shutdown just prints more jibberish.
>> > 
>> > -mm5 prints about half as much jibberish as -mm4 then hangs, seemingly
>> > halfway through boot.
>> > 
>> > I guess I'll try linus.patch from -mm4 next, unless you have any other
>> > suggestions that'd be more fruitful ...
>> 
>> OK, so -mm5 actually does the same as mm4 on my second try, so maybe the
>> hang is intermittent, or something.
>> 
>> However, linus.patch from -mm4 works fine, so the culprit is one of the
>> other patches in your tree ... any suggestions for which to shoot first? ;-)
>> 
> 
> Not really.  Are you using early printk?
> 
> The only patches I have which touch drivers/serial/ are
> 8250-resource-management-fix, linus, pmac_zilog-oops-fix, kgdb-ga.
> 
> Lots of patches against drivers/char/*, but I don't see how any of those
> can futz the serial settings.  I'm assuming you're using 8250?

Sometimes my own idleness saves my arse. I finally got around to debugging
it, and it's gone in rc3-mm2 ;-) Yes, was 8250 ...

Thanks,

M


