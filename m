Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUCTX0p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 18:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbUCTX0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 18:26:45 -0500
Received: from alt.aurema.com ([203.217.18.57]:29866 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S263571AbUCTX0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 18:26:43 -0500
Message-ID: <405CD322.1050303@aurema.com>
Date: Sun, 21 Mar 2004 10:26:26 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Micha Feigin <michf@post.tau.ac.il>, John Reiser <jreiser@BitWagon.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
References: <20040311141703.GE3053@luna.mooo.com>	<1079198671.4446.3.camel@laptop.fenrus.com>	<4053624D.6080806@BitWagon.com>	<20040313193852.GC12292@devserv.devel.redhat.com>	<40564A22.5000504@aurema.com>	<20040316063331.GB23988@devserv.devel.redhat.com>	<40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com>
In-Reply-To: <20040320102241.GK2803@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, Mar 17, 2004 at 10:38:03AM +1100, Peter Williams wrote:
> 
>>>there is one. Nothing uses it
>>>(sysconf() provides this info)
>>
>>Seems to me that it would be fairly trivial to modify those programs 
>>(that should use this mechanism but don't) to use it?  So why should 
>>they be allowed to dictate kernel behaviour?
> 
> 
> quality of implementation; for example shell scripts that want to do
> echo 500 > /proc/sys/foo/bar/something_in_HZ
> ...
> or /etc/sysctl.conf or ...
> 

A small utility program secs_to_ticks would solve this problem e.g.:

secs_to_ticks 0.5 > /proc/sys/foo/bar/something_in_HZ

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

