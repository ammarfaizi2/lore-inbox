Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSKUU35>; Thu, 21 Nov 2002 15:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSKUU35>; Thu, 21 Nov 2002 15:29:57 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:23852 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264649AbSKUU3y>; Thu, 21 Nov 2002 15:29:54 -0500
Date: Thu, 21 Nov 2002 15:38:29 -0500
From: Doug Ledford <dledford@redhat.com>
To: Steven Dake <sdake@mvista.com>
Cc: Joel Becker <Joel.Becker@oracle.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
Message-ID: <20021121203829.GH14063@redhat.com>
Mail-Followup-To: Steven Dake <sdake@mvista.com>,
	Joel Becker <Joel.Becker@oracle.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au> <20021120160259.GW806@nic1-pc.us.oracle.com> <15836.7011.785444.979392@notabene.cse.unsw.edu.au> <20021121014625.GA14063@redhat.com> <20021121193424.GB770@nic1-pc.us.oracle.com> <20021121195406.GF14063@redhat.com> <3DDD3AB6.2010105@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDD3AB6.2010105@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 12:57:42PM -0700, Steven Dake wrote:
> Doug,
> 
> EVMS integrates all of this stuff together into one cohesive peice of 
> technology.
> 
> But I agree, LVM should be modified to support RAID 1 and RAID 5, or MD 
> should be modified to support volume management.  Since RAID 1 and RAID 
> 5 are easier to implement, LVM is probably the best place to put all 
> this stuff.

Yep.  I tend to agree there.  A little work to make device mapping modular
in LVM, and a little work to make the md modules plug into LVM, and you
could be done.  All that would be left then is adding the right stuff into
the user space tools.  Basically, what irks me about the current situation
is that right now in the Red Hat installer, if I want LVM features I have
to create one type of object with a disk, and if I want reasonable
software RAID I have to create another type of object with partitions.  
That shouldn't be the case, I should just create an LVM logical volume,
assign physical disks to it, and then additionally assign the redundancy
or performance layout I want (IMNSHO) :-)


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
