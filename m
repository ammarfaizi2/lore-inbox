Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUCPXlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbUCPXlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:41:20 -0500
Received: from alt.aurema.com ([203.217.18.57]:46982 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261846AbUCPXiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:38:22 -0500
Message-ID: <40578FDB.9060000@aurema.com>
Date: Wed, 17 Mar 2004 10:38:03 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Micha Feigin <michf@post.tau.ac.il>, John Reiser <jreiser@BitWagon.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
References: <20040311141703.GE3053@luna.mooo.com>	<1079198671.4446.3.camel@laptop.fenrus.com>	<4053624D.6080806@BitWagon.com>	<20040313193852.GC12292@devserv.devel.redhat.com>	<40564A22.5000504@aurema.com> <20040316063331.GB23988@devserv.devel.redhat.com>
In-Reply-To: <20040316063331.GB23988@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, Mar 16, 2004 at 11:28:18AM +1100, Peter Williams wrote:
> 
>>>Ugh that should say 100 on x86....
>>>but..
>>>param.h:# define USER_HZ        100             /* .. some user interfaces 
>>>are in "ticks" */
>>>param.h:# define CLOCKS_PER_SEC (USER_HZ)       /* like times() */
>>>.....
>>>that looks like 100 to me.
>>>
>>
>>This horrible hack of converting all tick values to 100 (from 1000) for 
>>export to user space because a large number of user space programs 
>>assume that HZ is 100 would NOT be necessary if there was a mechanism 
>>whereby user space programs could find out how many ticks there are in a 
>>second instead of having to make assumptions.
> 
> 
> there is one. Nothing uses it
> (sysconf() provides this info)

Seems to me that it would be fairly trivial to modify those programs 
(that should use this mechanism but don't) to use it?  So why should 
they be allowed to dictate kernel behaviour?

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

