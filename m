Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263575AbUCTX66 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 18:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbUCTX66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 18:58:58 -0500
Received: from alt.aurema.com ([203.217.18.57]:3760 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S263575AbUCTX65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 18:58:57 -0500
Message-ID: <405CDAAD.5020308@aurema.com>
Date: Sun, 21 Mar 2004 10:58:37 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Stefan Smietanowski <stesmi@stesmi.com>,
       Micha Feigin <michf@post.tau.ac.il>, John Reiser <jreiser@BitWagon.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com> <4053624D.6080806@BitWagon.com> <20040313193852.GC12292@devserv.devel.redhat.com> <40564A22.5000504@aurema.com> <20040316063331.GB23988@devserv.devel.redhat.com> <40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com> <405C2AC0.70605@stesmi.com> <20040320114112.GA29102@devserv.devel.redhat.com>
In-Reply-To: <20040320114112.GA29102@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, Mar 20, 2004 at 12:28:00PM +0100, Stefan Smietanowski wrote:
> 
>>Then you include it in the default distro of choice so that
>>everybody can use it and there you are.
> 
> 
> but what is the POINT of all this changing/breaking ?
> Can someone at least tell me that ?

In the 2.6 kernels internal timing and task statistics (for i386 
systems) are now kept in milliseconds where they were previously in 
1/100ths of a second.  By converting these statistics to 1/100ths of a 
second for export to user space an order of magnitude (i.e. a factor of 
10) loss of precision occurs.

Peter
PS I'd like to point out that there are changes in 2.6 kernels that have 
more serious consequences than this that have to be coped with when 
using 2.6 kernels on distributions such as RedHat 9 that were built 
around older kernels.
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

