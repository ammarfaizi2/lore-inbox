Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUDEOIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 10:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbUDEOIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 10:08:25 -0400
Received: from wsp.xs4all.nl ([80.126.33.14]:29825 "EHLO wsprwl.xs4all.nl")
	by vger.kernel.org with ESMTP id S262574AbUDEOIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 10:08:22 -0400
Message-ID: <40716855.50900@xs4all.nl>
Date: Mon, 05 Apr 2004 16:08:21 +0200
From: Ruud Linders <rkmp@xs4all.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x kernels and ttyS45 for 6 serial ports ?
References: <4071367B.2060103@xs4all.nl> <20040405120452.B31038@flint.arm.linux.org.uk>
In-Reply-To: <20040405120452.B31038@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I realise that my 'patch' isn't the perfect solution.
But how much sense makes adding a 4-port card and getting
ttyS14/15/44/45 for these 4-ports ?

As the first 4 serial ports, on x86 at least, are more or less
on standard 3f8/2f8/3e8/2e8 IO-ports an argument could be made to
reserve ttyS0/1/2/3 for these.
Reserving ttyS0-S43 (with ttyS14-15 as spare) doesn't make sense
to me.
And what if my next mobo doesn't have serial ports anymore and I
plugin a PCI card, I would expect them to start at ttyS0.

Anyway, I just wanted to point out that
a)these are strange numbers from user point of view
b)over kernel versions my ports keep moving to different names
   and I'm NOT plugging in different hardware.

I guess I'll just do  "cd /dev;ln -nfs ttyS14 ttyS2" and be done
with it or use udev (good time as ever to give that a try) or
keep patching my kernel or ...

_
Ruud

Now my PCI ports are moving between kernel versions
Russell King wrote:
> On Mon, Apr 05, 2004 at 12:35:39PM +0200, Ruud Linders wrote:
> 
>>Now checking this on 2.6.5 it got more confusing, I now have with
>>total of 6 serial ports a device number ttyS45 !?
> 
> 
> And what happens if you detect a PCI modem at IO address 0x2e8 after
> you've detected your PCI card and assigned it ttyS4?
> 
> Don't you think that would complain that their modem should be assigned
> ttyS4 rather than their PCI multiport card getting it?
> 
