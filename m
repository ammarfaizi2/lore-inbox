Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267697AbUHEOzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267697AbUHEOzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267723AbUHEOzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:55:50 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:29082 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S267697AbUHEOzc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:55:32 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Thu, 5 Aug 2004 10:55:29 -0400
User-Agent: KMail/1.6.82
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org> <200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408051055.30018.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [141.153.92.242] at Thu, 5 Aug 2004 09:55:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 04:33, Denis Vlasenko wrote:
>Hi Linus,
>
>On Thursday 05 August 2004 10:25, Linus Torvalds wrote:
>> On Wed, 4 Aug 2004, Gene Heskett wrote:
>> > I *thought* I had PREEMPT turned off, but when I did a make
>> > xconfig, it was turned on.  So its now off, and a new 2.6.8-rc3
>> > is building. It was frame pointers I had turned on for the last
>> > build, still on for this one underway now.
>>
>> Your latest bug report definitely had preempt on, you could see
>> the preempt code in the oops output when disassembled.
>>
>> Also, could you please enable CONFIG_DEBUG_BUGVERBOSE by hand if
>> you use the -mm tree, since you definitely hit a BUG() in there
>> somewhere, but in the -mm tree, the BUG()  message is totally
>> unreadable unless you enable BUGVERBOSE (and it's not in the
>> config file).
>
>It is not a BUG().
>
>It's an oops (dereferencing a d_op pointer with value 0x00000900+14
>IIRC, Gene has complete disassembly with location of that event).

Unforch Denis, this is 2.6.8-rc3, the stuff we dissed was from 2.6.7, 
where it can be hit without (usually that is) killing the machine 
instantly.  From 2.6.7-mm1 on, the death seems generally sudden and 
instant, generally no logs get written at all.

>It is not reproducible on request, but happens for him from time
>to time in the same place with the same bogus value of d_op.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
