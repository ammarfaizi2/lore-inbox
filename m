Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272203AbRHWDYf>; Wed, 22 Aug 2001 23:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272202AbRHWDYY>; Wed, 22 Aug 2001 23:24:24 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:20486 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272201AbRHWDYP>; Wed, 22 Aug 2001 23:24:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Jeff Busch" <jbusch@half.com>, <linux-kernel@vger.kernel.org>,
        <roswell-list@redhat.com>
Subject: Re: [problem] RH 2.4.7-2 kernel slows to a crawl under heavy i/o
Date: Thu, 23 Aug 2001 05:31:05 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <NEBBJGKHGENBAPAMDILGIEFGGOAA.jbusch@half.com>
In-Reply-To: <NEBBJGKHGENBAPAMDILGIEFGGOAA.jbusch@half.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010823032430Z16090-32383+937@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 22, 2001 11:57 pm, Jeff Busch wrote:
> machine:  Compaq Proliant DL360 w/4GB mem, dual 36GB SCSI drives
> OS:	    RedHat 7.1 + errata updates, kernel-enterprise-2.4.7-2.i686.rpm from
> 'Roswell 2'
> 
> Under heavy I/O (Apache and a custom C++ module which do lots of mmap and
> munmap calls over large data sets - 7GB total), the machine slows to a
> crawl.  The problem persists even after live traffic to the machine ceases.
> A top listing shows both cpu's at 100% system.  Any commands (ps, uname,
> whatever) take minutes to return results.
> 
> The same setup on RH 6.2 with 2.4.3-ac3 works fine.  Please let me know what
> information may be useful to debugging this problem (no oops yet), and other
> kernels to try; I'm looking at 2.4.8-ac9 right now.

I'd suggest:

  watch cat /proc/meminfo
  watch cat /proc/slabinfo

And also, please try 2.4.9 as well as -ac

--
Daniel
