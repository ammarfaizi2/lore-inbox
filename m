Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUDBWIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUDBWIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:08:16 -0500
Received: from alt.aurema.com ([203.217.18.57]:42369 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261197AbUDBWGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:06:50 -0500
Message-ID: <406DE38C.8010502@aurema.com>
Date: Sat, 03 Apr 2004 08:05:00 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Bird <tim.bird@am.sony.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, Richard.Curnow@superh.com, ak@muc.de,
       Arjan van de Ven <arjanv@redhat.com>, aeb@cwi.nl,
       Jamie Lokier <jamie@shareable.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: finding out the value of HZ from userspace
References: <1079453698.2255.661.camel@cube>	<20040320095627.GC2803@devserv.devel.redhat.com>	<1079794457.2255.745.camel@cube> <405CDA9C.6090109@aurema.com>	<20040331134009.76ca3b6d.rddunlap@osdl.org>	<1080776817.2233.2326.camel@cube>	<20040401155420.GB25502@mail.shareable.org>	<20040401160132.GB13294@devserv.devel.redhat.com>	<20040401163047.GD25502@mail.shareable.org>	<406CAEB6.6080709@aurema.com>	<20040402003937.GC28520@mail.shareable.org>	<406CC589.8050208@aurema.com> <406DB0B0.8060003@am.sony.com>
In-Reply-To: <406DB0B0.8060003@am.sony.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Bird wrote:
> Peter Williams wrote:
> 
>>> It's not possible to change USER_HZ.  There are too many programs with
>>> the number hard-coded into the binary.
>>
>>
>> This is an argument that the tail should be allowed to wag the dog and 
>> is not really valid :-)
> 
> 
> It is an interesting, but untenable, position that the applications
> are the tail and the OS is the dog.  The OS exists to serve the 
> applications.
> The applications, are, after all what a user actually DOES with their 
> computer.

I guess wagging was a bad analogy.  I was thinking in terms of the 
kernel being the main entity and the programs being peripheral in the 
sense that the kernel can exist without the programs but the programs 
can't exist without the kernel.

> 
> It is possible that the current applications which use hardcoded USER_HZ 
> are
> not important enough, or are easy enough to fix, that the cost in 
> incompatibility
> is offset by the benefit of providing different behaviour for future 
> applications.

Yes, this is the real point is that the facilities provided by the 
kernel shouldn't be tailored/compromised to cope with the problems of a 
couple of buggy programs especially when fixing the programs would be 
trivial.  I don't think the importance of the program is an issue as I 
doubt that there is any program that is so important that its 
requirements dictate kernel design.

> 
> But breaking them for no good reason, and particularly while there is a
> migration path possible over time which does not break compatibility, 
> seems like
> a bad idea.

Far more important things than these programs have been "broken" by 
changes in the kernel (I know, I've had to cope with them getting 2.6.X 
kernels to work with Red Hat 9) but no one complains or suggests that 
the kernel should revert to its original behaviour.  Change is part of 
progress and has to be coped with not resisted for no good reason.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

