Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261757AbSJQECH>; Thu, 17 Oct 2002 00:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261769AbSJQECH>; Thu, 17 Oct 2002 00:02:07 -0400
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:42118
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S261757AbSJQECG>; Thu, 17 Oct 2002 00:02:06 -0400
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Michael Clark <michael@metaparadigm.com>
Cc: Simon Roscic <simon.roscic@chello.at>, linux-kernel@vger.kernel.org
In-Reply-To: <3DAE3465.6060006@metaparadigm.com>
References: <200210152120.13666.simon.roscic@chello.at>
	 <200210152153.08603.simon.roscic@chello.at>
	 <3DACD41F.2050405@metaparadigm.com>
	 <200210161828.18985.simon.roscic@chello.at>
	 <3DAD988B.40704@metaparadigm.com> <1034824350.26.33.camel@localhost>
	 <3DAE3465.6060006@metaparadigm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1034827683.26.76.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 16 Oct 2002 23:08:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 22:54, Michael Clark wrote:
> On 10/17/02 11:12, GrandMasterLee wrote:
> > On Wed, 2002-10-16 at 11:49, Michael Clark wrote:
> >>Seems to be the correlation so far. qlogic driver without lvm works okay.
> >>qlogic driver with lvm, oopsorama.
> > 
> > 
> > Michael, what exactly do your servers do? Are they DB servers with ~1Tb
> > connected, or file-servers with hundreds of gigs, etc?
> 
> My customer currently has about 400Gb on this particular 4 node Application
> cluster (actually 2 x 2 node clusters using kimberlite HA software).
> 
> It has 11 logical hosts (services) spread over the 4 nodes with services such
> as Oracle 8.1.7, Oracle Financials (11i), a busy openldap server, and busy
> netatalk AppleShare Servers, Cyrus IMAP server. All are on ext3 partitions
> and were previously using LVM to slice up the storage.

On each of the Nodes, correct?

> The cluster usually has around 200-300 active users.
> 
> We have had oops (in ext3) on differing logical hosts which where running
> different services. ie. has oopsed on the node mastering the fileserver,
> and also on the node mastering the oracle database.

And again, each was running LVM in a shared storage mode for failover?

> Cross fingers, since removing LVM (which was the only change we have made,
> same kernel) we have had 3 times our longest uptime and still counting.
> 
> By the sounds, from earlier emails I had posted, users had responded
> to me who were also using qlogic and none of them had had any problems,
> the key factor was none of them were running LVM - this is what made
> me think to try and remove it (it was really just a hunch). We had
> gone through months of changing kernel versions, changing GigE network
> adapters, driver versions, etc, to no avail, then finally the LVM removal.

Kewl. That makes me feel much better now too. 

> Due to the potential nature of it being a stack problem. The problem
> really can't just be pointed at LVM but more the additive effect this
> would have on some underlying stack problem.
> 
> I believe the RedHat kernels i tried (rh7.2 2.4.9-34 errata was the most
> recent) also had this 'stack' problem. I am currently using 2.4.19pre10aa4.

Kewl. I'm using 2.4.19-aa1 (rc5-aa1, but hell, it's the same thing).

> I would hate to reccomend you remove LVM and it not work, but i
> must say it has worked for me (i'm just glad i didn't go to XFS instead
> of removing LVM as i did - as this was the other option i was pondering).

I hear you. We were pondering changing to EXT3, and not just EXT3, RHAS
also. i.e. more money, unknown kernel config, etc. I was going to be
*very* upset.  Are you running FC2(qla2300Fs in FC2 config) or FC1?

TIA

> ~mc
> 
