Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263576AbUCTX7J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 18:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263577AbUCTX7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 18:59:09 -0500
Received: from alt.aurema.com ([203.217.18.57]:14732 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S263576AbUCTX7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 18:59:04 -0500
Message-ID: <405CDA9C.6090109@aurema.com>
Date: Sun, 21 Mar 2004 10:58:20 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
CC: Arjan van de Ven <arjanv@redhat.com>, ak@muc.de, Richard.Curnow@superh.com,
       aeb@cwi.nl, linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: finding out the value of HZ from userspace
References: <1079453698.2255.661.camel@cube>	<20040320095627.GC2803@devserv.devel.redhat.com> <1079794457.2255.745.camel@cube>
In-Reply-To: <1079794457.2255.745.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> On Sat, 2004-03-20 at 04:56, Arjan van de Ven wrote:
> 
>>On Tue, Mar 16, 2004 at 11:14:59AM -0500, Albert Cahalan wrote:
>>
>>>>there is one. Nothing uses it
>>>>(sysconf() provides this info)
>>>
>>>If you have a recent glibc on a recent kernel, it might.
>>>You could also get a -1 or a supposed ABI value that
>>>has nothing to do with the kernel currently running.
>>>The most reliable way is to first look around on the
>>>stack in search of ELF notes, and then fall back to
>>>some horribly gross hacks as needed.
>>
>>eh sysconf() is the nice way to get to the ELF notes
>>instead of having to grovel yourself.
> 
> 
> Unless there is some hidden feature that lets
> me specify the ELF note number directly, no way.
> 
> The sysconf(_SC_CLK_TCK) call does not return an
> error code when used on a 2.2.xx i386 kernel.
> You get an arbitrary value that fails for ARM,
> Alpha, and any system with modified HZ.

As Linux is supposed to be POSIX compliant this is a bug and should be 
fixed.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

