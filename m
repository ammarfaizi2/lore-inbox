Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbSKUXnL>; Thu, 21 Nov 2002 18:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267210AbSKUXnB>; Thu, 21 Nov 2002 18:43:01 -0500
Received: from [213.213.74.131] ([213.213.74.131]:15830 "EHLO percy.comedia.it")
	by vger.kernel.org with ESMTP id <S267208AbSKUXmk>;
	Thu, 21 Nov 2002 18:42:40 -0500
Date: Fri, 22 Nov 2002 00:49:47 +0100
From: Luca Berra <bluca@comedia.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Steven Dake <sdake@mvista.com>, Doug Ledford <dledford@redhat.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org, Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: DM vs MD (Was: RFC - new raid superblock layout for md driver)
Message-ID: <20021121234946.GC23949@percy.comedia.it>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Steven Dake <sdake@mvista.com>, Doug Ledford <dledford@redhat.com>,
	Joel Becker <Joel.Becker@oracle.com>,
	Neil Brown <neilb@cse.unsw.edu.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-raid@vger.kernel.org,
	Joe Thornber <joe@fib011235813.fsnet.co.uk>
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au> <20021120160259.GW806@nic1-pc.us.oracle.com> <15836.7011.785444.979392@notabene.cse.unsw.edu.au> <20021121014625.GA14063@redhat.com> <20021121193424.GB770@nic1-pc.us.oracle.com> <20021121195406.GF14063@redhat.com> <3DDD3AB6.2010105@mvista.com> <1037914176.9122.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1037914176.9122.2.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 09:29:36PM +0000, Alan Cox wrote:
>On Thu, 2002-11-21 at 19:57, Steven Dake wrote:
>> Doug,
>> 
>> EVMS integrates all of this stuff together into one cohesive peice of 
>> technology.
>> 
>> But I agree, LVM should be modified to support RAID 1 and RAID 5, or MD 
>> should be modified to support volume management.  Since RAID 1 and RAID 
>> 5 are easier to implement, LVM is probably the best place to put all 
>> this stuff.
>
>User space issue. Its about the tools view not about the kernel drivers.
>
Ok,
dm should be modified to support raid1 or raid5 or raidwhatever,
probably using code from md (included or as a module) and md 
should be modified to use dm for the request mapping work.
problem is that raid needs some way to keep state so wether we want to
keep it in md superblock on in LVM metadata we need to do this in kernel
space.
And i don't feel dm is the correct place for this, unless Joe has a
very elegant solution :)

L.

-- 
Luca Berra -- bluca@comedia.it
        Communication Media & Services S.r.l.
 /"\
 \ /     ASCII RIBBON CAMPAIGN
  X        AGAINST HTML MAIL
 / \
