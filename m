Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319053AbSIDFHk>; Wed, 4 Sep 2002 01:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319056AbSIDFHj>; Wed, 4 Sep 2002 01:07:39 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:48293 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319053AbSIDFHi>; Wed, 4 Sep 2002 01:07:38 -0400
Date: Tue, 03 Sep 2002 22:10:47 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Greg KH <greg@kroah.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com
Subject: Re: [BUG] 2.5.33 PCI and/or starfire.c broken
Message-ID: <100427997.1031091046@[10.10.2.3]>
In-Reply-To: <20020904050401.GA4019@kroah.com>
References: <20020904050401.GA4019@kroah.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Well, something ugly has happened no 2.5.33's PCI:
>> > 
>> > Somehow SCSI works, but starfire.c doesn't.
>> 
>> It's confused by having a PCI-PCI bridge on a quad other than 0,
>> where the global and local PCI bus numbers don't line up. Rip
>> the card out, or get the horrible kludge I did for 2.4, and use 
>> that.
> 
> Might I suggest you port that "kludge" to the new 2.5 pci code, as the
> whole goal of those large PCI changes was due to some NUMA changes that
> you and Matt wanted to get into the main kernel.
> 
> Remember, you have your own file to play with now, so put all the
> brain-damaged NUMA crap into it :)

Yeah, I'll clean it up enough to be able to show my face in public
at some point, but I think it'll work for now. Or turn nr_ioapics 
down to 2 ;-) ... should allow him to test for the softirq bug
at least.

M.

