Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319198AbSIKJVZ>; Wed, 11 Sep 2002 05:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319199AbSIKJVZ>; Wed, 11 Sep 2002 05:21:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13637 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S319198AbSIKJVY>; Wed, 11 Sep 2002 05:21:24 -0400
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <20020905.204721.49430679.davem@redhat.com>
	<18563262.1031269721@[10.10.2.3]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Sep 2002 03:11:49 -0600
In-Reply-To: <18563262.1031269721@[10.10.2.3]>
Message-ID: <m1hegwoppm.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <Martin.Bligh@us.ibm.com> writes:

> > Ie. the headers that don't need to go across the bus are the critical
> > resource saved by TSO.
> 
> I'm not sure that's entirely true in this case - the Netfinity
> 8500R is slightly unusual in that it has 3 or 4 PCI buses, and
> there's 4 - 8 gigabit ethernet cards in this beast spread around
> different buses (Troy - are we still just using 4? ... and what's
> the raw bandwidth of data we're pushing? ... it's not huge). 
> 
> I think we're CPU limited (there's no idle time on this machine), 
> which is odd for an 8 CPU 900MHz P3 Xeon,

Quite possibly.  The P3 has roughly an 800MB/s FSB bandwidth, that must
be used for both I/O and memory accesses.  So just driving a gige card at
wire speed takes a considerable portion of the cpus capacity.  

On analyzing this kind of thing I usually find it quite helpful to
compute what the hardware can theoretically to get a feel where the
bottlenecks should be.

Eric
