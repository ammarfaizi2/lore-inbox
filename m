Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbTDWQbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbTDWQbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:31:45 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:47803 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S264119AbTDWQal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:30:41 -0400
Message-ID: <3EA6C0F9.1010406@cox.net>
Date: Wed, 23 Apr 2003 09:36:09 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.68 kernel no initrd
References: <000701c306f6$cf100180$0200a8c0@satellite> <1050859494.595.4.camel@teapot.felipe-alfaro.com>            <Pine.LNX.4.51L.0304231547460.12634@piorun.ds.pg.gda.pl> <200304231600.h3NG0aCs019316@turing-police.cc.vt.edu>
In-Reply-To: <200304231600.h3NG0aCs019316@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> On Wed, 23 Apr 2003 15:49:54 +0200, =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= said:
> 
>>initrd gives much more flexibility.
>>I can make one kernel and use it on _all_ of my mashines, just change 
>>initrd. quick, nice and flexible with proper initrd tools set.
> 
> 
> Amen.  initrd isn't just for modules - I'd not need an initrd at all if I could
> figure out how to start up an LVM volume group from kernelspace - I suspect
> people with / on a RAID disk have similar issues...
> 

Well, even though I'm working on a solution to that, it still involves 
early userspace, just not the heavyweight "fake root" userspace that an 
initrd represents. This is what the initramfs technology in 2.5.X is 
for, so eventually (soon, hopefully) you'll be able to start md devices, 
LVM volume groups, etc. from early userspace and not have to have any 
autostart logic in the kernel nor will you have build and maintain an 
initrd separate from the kernel.

