Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbWAJVGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbWAJVGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWAJVGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:06:49 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:40423 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932611AbWAJVGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:06:48 -0500
Date: Tue, 10 Jan 2006 22:06:27 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andi Kleen <ak@suse.de>
cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Console debugging wishlist was: Re: oops pauser.
In-Reply-To: <200601102145.53967.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0601102200410.1000@yvahk01.tjqt.qr>
References: <20060105045212.GA15789@redhat.com> <p73vewtw8bh.fsf@verdi.suse.de>
 <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr> <200601102145.53967.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-ENOPARSE

Try the oops.ko from http://jengelh.hopto.org/f/oops_ko.tbz2. It won't kill
your system, you can continue to work.

If you now had a kernel-level pager that would jump in everytime an oops
happened, control would normally not be given back to userspace unless we quit
the pager. kdb has a similar behavior: it "stops" userspace until someone
chooses to "c"ontinue.
Therefore this pager would not be too good. In a panic, yes, it would be 
perfect.

I hope this makes it a little bit clearer, if not, -EAGAIN.

>> >(it is hard to understand that with 128MB+ graphic cards and 512+MB
>> >computers the scroll back must be still so short...) 
>> 
>> I doubt this scrollback buffer is implemented as part of the video cards. 
>> It is rather a kernel invention, and therefore uses standard RAM. But the 
>> idea is good, preferably make it a CONFIG_ option.
>
>At least long ago (when I last looked) it was in video RAM. 

Let's put it from another POV: if the scrollback buffer was somewhere within
the video card, it would usually not be cleared when you change from one
console tty to another. Currently, doing this switch clears the buffer (can we
do anything about that? - would be great)



Jan Engelhardt
-- 
