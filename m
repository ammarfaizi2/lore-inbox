Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270505AbTGXHhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 03:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270507AbTGXHhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 03:37:11 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:14754 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S270505AbTGXHhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 03:37:08 -0400
Message-ID: <3F1F9016.4030908@redhat.com>
Date: Thu, 24 Jul 2003 03:51:50 -0400
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: backblue <backblue@netcabo.pt>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Error compiling, scsi 2.6.0-test1
References: <Sea2-F42G9i3HGRgKuw00017dcf@hotmail.com>	 <ODEIIOAOPGGCDIKEOPILAEBDCNAA.alan@storlinksemi.com>	 <20030716232827.2272eccb.backblue@netcabo.pt>	 <1058442701.8621.26.camel@dhcp22.swansea.linux.org.uk>	 <20030717195952.130827f5.backblue@netcabo.pt> <1058547612.1632.61.camel@spc9.esa.lanl.gov>
In-Reply-To: <1058547612.1632.61.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> On Thu, 2003-07-17 at 12:59, backblue wrote:
> 
>>hello Alan,
>>
>>I need this driver, but i dont know anouth of C, to code a new one, that old's on 2.6.0 :(, where to start? i really need it, i have everything scsi on my computer, with this controler, and i dont like the idea, of dont have suport to it!!
>>On 17 Jul 2003 12:51:42 +0100
>>Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>
>>
>>>On Mer, 2003-07-16 at 23:28, backblue wrote:
>>>
>>>>I have gcc 3.3, on x86 machine, i have this error, compiling the suport for my scsi card, someone know the problem?
>>>
>>>Nobody has coverted this driver to 2.6 yet. If someone does then it will
>>>get merged in, if not the initio support will get deleted in time.
>>>
> 
> 
> It looks like this came up a year ago:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=102526383927111&w=2
> 
> You might plead with Doug to finish the conversion.
> 
> Steven

I wretched horribly when I read that driver.  Then I started to renounce 
my computer ways to become a Tibetten Monk and live out the remainder of 
my days in peace and solice.  Unfortunately, about that time, a space 
thread passed another thread, opened up a short lived wormhole, and I 
got a futuristic glimpse of myself in a robe and bald and I immediately 
came back to my senses.  I still couldn't handle that driver code 
though.  The urge to fix massive brokenness other than just PCI DMA code 
issues was overwhelming to my right hand's obsessive/compulsive disorder.

However, as a hint to anyone out there, I fixed the other initio driver 
a long ways back.  A person could pull those 3 (I think) changesets from 
the kernel tree and see what I did.  If you ignore all the changes to 
eliminate the fixed array of hosts and that kind of crap, and just 
concentrate on the changes that involve the PCI DMA mapping, they should 
apply almost perfectly into this other initio driver as they are very 
close copies of each other.


-- 
   Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
            Red Hat, Inc.
            1801 Varsity Dr.
            Raleigh, NC 27606


