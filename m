Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbUCUBcF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 20:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbUCUBcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 20:32:05 -0500
Received: from alt.aurema.com ([203.217.18.57]:14773 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S263588AbUCUBcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 20:32:02 -0500
Message-ID: <405CF03B.7090801@aurema.com>
Date: Sun, 21 Mar 2004 12:30:35 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Arjan van de Ven <arjanv@redhat.com>,
       Stefan Smietanowski <stesmi@stesmi.com>,
       Micha Feigin <michf@post.tau.ac.il>, John Reiser <jreiser@BitWagon.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com> <4053624D.6080806@BitWagon.com> <20040313193852.GC12292@devserv.devel.redhat.com> <40564A22.5000504@aurema.com> <20040316063331.GB23988@devserv.devel.redhat.com> <40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com> <405C2AC0.70605@stesmi.com> <20040320114112.GA29102@devserv.devel.redhat.com> <405CDAAD.5020308@aurema.com> <Pine.LNX.4.53.0403210202120.24035@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0403210202120.24035@gockel.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
> On Sun, 21 Mar 2004, Peter Williams wrote:
> 
> 
>>In the 2.6 kernels internal timing and task statistics (for i386 
>>systems) are now kept in milliseconds where they were previously in 
>>1/100ths of a second.  By converting these statistics to 1/100ths of a 
>>second for export to user space an order of magnitude (i.e. a factor of 
>>10) loss of precision occurs.
> 
> 
> No. The statistics are not a result of full bookkeeping, but simply
> gained by periodically sampling the processor state. So they don't
> have a precision of 1/1000th of a second anyways.

1/1000th of a second IS the internal timing precision.  The issue of how 
tasks' CPU usage is allocated for reporting is a different matter but 
from a statistical viewpoint this will just effect the variance (or 
standard deviation) of the estimates and NOT their precision. As the 
number of samples the variance (or standard deviation) decrease rapidly 
so to all intents and purposes the statistics are accurate to the 
nearest 1/1000th of a second.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

