Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUHVHbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUHVHbq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 03:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUHVHbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 03:31:46 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:14255 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S266425AbUHVHbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 03:31:44 -0400
Message-ID: <56689.210.86.92.219.1093159902.squirrel@mail.metaparadigm.com>
In-Reply-To: <20040818135314.GJ467@openzaurus.ucw.cz>
References: <41131120.5060202@metaparadigm.com>
    <20040818135314.GJ467@openzaurus.ucw.cz>
Date: Sun, 22 Aug 2004 15:31:42 +0800 (SGT)
Subject: Re: [PATCH] - Initial dothan speedstep support
From: "Clark, Michael" <michael@metaparadigm.com>
To: "Pavel Machek" <pavel@suse.cz>
Cc: "Michael Clark" <michael@metaparadigm.com>, jeremy@goop.org,
       davej@codemonkey.org.uk, "Linux Kernel" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
>
>> So here's a patch on top of the above patch that adds all of the
>> dothan frequency/voltages for processors 715, 725, 735, 745, 755
>>
>> Tested and working as it should so far with a 745. The stepping in the
>> model table for the others may need to be tweaked.
>>
>> The Dothan processor datasheet 30218903.pdf defines 4 voltages for
>> each frequency (VID#A through VID#D) whereas Banias only suggests a
>> typical voltage and no min or max for each freq so i've used the OP
>> macro to allow definition of all voltages (A through D) but the macro
>> currently just uses VID#C at compile time (the second lowest voltage
>> profile).
>
> I thought that whether to use VID#A, B, C or D depends on
> your concrete chip? Not all chips are certified to run on VID#C...

Yes, I believe this is the case. When I read the processor spec
document it did not mention this but since then i found this out. I've
since changed the patch to use the VID#A voltages which is more
conservative (assuming that all of them will run at the higher voltage
okay which according to the upper voltage rating of 1.6 volts might be
okay). It would of course be preferrable to work out the the type
VID#A,B,C,D via software - not sure if this is possible.

~mc
