Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVLBECG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVLBECG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 23:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVLBECG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 23:02:06 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:5557 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750965AbVLBECF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 23:02:05 -0500
Date: Thu, 01 Dec 2005 23:01:58 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Gene's pcHDTV 3000 analog problem
In-reply-to: <1133486311.2969.11.camel@frolic>
To: video4linux-list@redhat.com, mkrufky@m1k.net, linux-kernel@vger.kernel.org
Cc: R C <v4l@cerqueira.org>
Message-id: <200512012301.58843.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <200512011903.41058.gene.heskett@verizon.net> <1133486311.2969.11.camel@frolic>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 December 2005 20:18, R C wrote:
Gene adds: And damn, I've lost track of the original message that
contained this patch being discussed.  So some have been inadvertantly
left out of this thread, my apologies.

>Gene;
>
>On Thu, 2005-12-01 at 19:03 -0500, Gene Heskett wrote:
>
>[snip]
>
>> Ok, that I can probably do.  Unforch, there is a miss-cue in that
>> file, rc4 says:
>> struct cx88_board cx88_boards[] = {
>>         [CX88_BOARD_UNKNOWN] = {
>>                 .name           = "UNKNOWN/GENERIC",
>>                 .tuner_type     = UNSET,
>>                 .radio_type     = UNSET,
>>                 .tuner_addr     = ADDR_UNSET,
>>                 .radio_addr     = ADDR_UNSET,
>>                 .input          = {{
>>                         .type   = CX88_VMUX_COMPOSITE1,
>>
>> Note also that the .type = label has been changed.  I'm going to
>> change that line back to CX88_VMUX_TELEVISION, just for grins.
>>
>> While the patch says:
>> @@ -569,6 +569,7 @@ struct cx88_board cx88_boards[] = {
>>                 .radio_type     = UNSET,
>>                 .tuner_addr     = ADDR_UNSET,
>>                 .radio_addr     = ADDR_UNSET,
>>                 .tda9887_conf   = TDA9887_PRESENT,
>>                 .input          = {{
>>                         .type   = CX88_VMUX_TELEVISION,
>>                         .vmux   = 0,
>
>This means the patch applies _somewhere in_ that struct, not at the top
>of said struct. You're changing the entry for the default
>(unrecognized/generic) board (which won't get you anywhere), and the
>patch edits the pchdtv3000 entry (around line 569, or 530 lines below
>where you're editing)

After properly applying the patch, I'm now watching tv while booted to
2.6.15-rc4.  And it didn't take a cold boot to do it.  Hurrah!

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.


