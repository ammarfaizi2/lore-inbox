Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318870AbSIKOIU>; Wed, 11 Sep 2002 10:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318769AbSIKOIU>; Wed, 11 Sep 2002 10:08:20 -0400
Received: from franka.aracnet.com ([216.99.193.44]:32702 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S318870AbSIKOIT>; Wed, 11 Sep 2002 10:08:19 -0400
Date: Wed, 11 Sep 2002 07:10:57 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
Message-ID: <477096648.1031728254@[10.10.2.3]>
In-Reply-To: <m1hegwoppm.fsf@frodo.biederman.org>
References: <m1hegwoppm.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Ie. the headers that don't need to go across the bus are the critical
>> > resource saved by TSO.
>> 
>> I'm not sure that's entirely true in this case - the Netfinity
>> 8500R is slightly unusual in that it has 3 or 4 PCI buses, and
>> there's 4 - 8 gigabit ethernet cards in this beast spread around
>> different buses (Troy - are we still just using 4? ... and what's
>> the raw bandwidth of data we're pushing? ... it's not huge). 
>> 
>> I think we're CPU limited (there's no idle time on this machine), 
>> which is odd for an 8 CPU 900MHz P3 Xeon,
> 
> Quite possibly.  The P3 has roughly an 800MB/s FSB bandwidth, that must
> be used for both I/O and memory accesses.  So just driving a gige card at
> wire speed takes a considerable portion of the cpus capacity.  
> 
> On analyzing this kind of thing I usually find it quite helpful to
> compute what the hardware can theoretically to get a feel where the
> bottlenecks should be.

We can push about 420MB/s of IO out of this thing (out of that 
theoretical 800Mb/s). Specweb is only pushing about 120MB/s of
total data through it, so it's not bus limited in this case.
Of course, I should have given you that data to start with, 
but ... ;-)

M.

PS. This thing actually has 3 system buses, 1 for each of the two
sets of 4 CPUs, and 1 for all the PCI buses, and the three buses
are joined by an interconnect in the middle. But all the IO goes
through 1 of those buses, so for the purposes of this discussion,
it makes no difference whatsoever ;-)
