Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbSKUUlQ>; Thu, 21 Nov 2002 15:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbSKUUlQ>; Thu, 21 Nov 2002 15:41:16 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:35061 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S264716AbSKUUlO>; Thu, 21 Nov 2002 15:41:14 -0500
Message-ID: <3DDD46E0.9040909@mvista.com>
Date: Thu, 21 Nov 2002 13:49:36 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Joel Becker <Joel.Becker@oracle.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au> <20021120160259.GW806@nic1-pc.us.oracle.com> <15836.7011.785444.979392@notabene.cse.unsw.edu.au> <20021121014625.GA14063@redhat.com> <20021121193424.GB770@nic1-pc.us.oracle.com> <20021121195406.GF14063@redhat.com> <3DDD3AB6.2010105@mvista.com> <20021121203829.GH14063@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug,

Yup this would be ideal and I think this is what EVMS tries to do, 
although I haven't tried it.

The advantage of doing such a thing would also be that MD could be made 
to work with shared LVM VGs for shared storage environments.

now to write the code...

-steve

Doug Ledford wrote:

>On Thu, Nov 21, 2002 at 12:57:42PM -0700, Steven Dake wrote:
>  
>
>>Doug,
>>
>>EVMS integrates all of this stuff together into one cohesive peice of 
>>technology.
>>
>>But I agree, LVM should be modified to support RAID 1 and RAID 5, or MD 
>>should be modified to support volume management.  Since RAID 1 and RAID 
>>5 are easier to implement, LVM is probably the best place to put all 
>>this stuff.
>>    
>>
>
>Yep.  I tend to agree there.  A little work to make device mapping modular
>in LVM, and a little work to make the md modules plug into LVM, and you
>could be done.  All that would be left then is adding the right stuff into
>the user space tools.  Basically, what irks me about the current situation
>is that right now in the Red Hat installer, if I want LVM features I have
>to create one type of object with a disk, and if I want reasonable
>software RAID I have to create another type of object with partitions.  
>That shouldn't be the case, I should just create an LVM logical volume,
>assign physical disks to it, and then additionally assign the redundancy
>or performance layout I want (IMNSHO) :-)
>
>
>  
>

