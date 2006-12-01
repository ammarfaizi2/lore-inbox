Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967525AbWLAITl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967525AbWLAITl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 03:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967534AbWLAITl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 03:19:41 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:927 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S967525AbWLAITl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 03:19:41 -0500
Date: Fri, 1 Dec 2006 09:19:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rt1 - failed to boot on AMD64
Message-ID: <20061201081936.GA24896@elte.hu>
References: <5bdc1c8b0611301504y6d5b957et350bad438c5e636c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0611301504y6d5b957et350bad438c5e636c@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Knecht <markknecht@gmail.com> wrote:

>   OK, so 2.6.19-rt1 starts booting, gets to the point where it see the 
> keyboard and mouse, and then apparently starts looking for a remote 
> NFS server? I don't remember seeing this on earlier kernels.

if you have a Fedora 5/6-ish setup then you might be better off by 
trying my yum rpm kernels, via:

   cd /etc/yum.repos.d
   wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo

   yum install kernel-rt.x86_64

by the looks of it something changed in the .config that prevented your 
block device from being detected - and after that the kernel fell back 
to other methods of booting.

another thing, is your /etc/fstab using labels, or explicit devices? 
IIRC labels are needed i think by the new SATA/PATA code, a'ka:

  LABEL=/                 /                       ext3    noatime,nodiratime 1 1

	Ingo
