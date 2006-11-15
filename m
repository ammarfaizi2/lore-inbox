Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030849AbWKOSoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030849AbWKOSoQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030852AbWKOSoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:44:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030849AbWKOSoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:44:14 -0500
Date: Wed, 15 Nov 2006 10:39:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, William Cohen <wcohen@redhat.com>,
       Eric Dumazet <dada1@cosmosbay.com>, Komuro <komurojun-mbn@nifty.com>,
       Ernst Herzberg <earny@net4u.de>, Andre Noll <maan@systemlinux.org>,
       oprofile-list@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>,
       linux-usb-devel@lists.sourceforge.net, phil.el@wanadoo.fr,
       Adrian Bunk <bunk@stusta.de>, Ingo Molnar <mingo@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>,
       Prakash Punnoor <prakash@punnoor.de>, Len Brown <len.brown@intel.com>,
       Alex Romosan <romosan@sycorax.lbl.gov>,
       Linus Torvalds <torvalds@osdl.org>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [discuss] Re: 2.6.19-rc5: known regressions (v3)
Message-Id: <20061115103915.46a70283.akpm@osdl.org>
In-Reply-To: <200611151748.05989.ak@suse.de>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<200611151150.11275.ak@suse.de>
	<455B4314.3010503@redhat.com>
	<200611151748.05989.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 17:48:05 +0100
Andi Kleen <ak@suse.de> wrote:

> 
> > OProfile has a simplistic view of the performance monitoring hardware. The 
> > routines in libop/op_alloc_counter.c determine what set of performance registers 
> > is available from the processor in use. There is no check to see what registers 
> > are actually available in the /dev/oprofile directory.
> > 
> > opcontrol executes ophelp to determine which specific counters to count which 
> > events. The function map_event_to_counter() in libop/op_alloc_counter.c does the 
> > actual selection. It seems what is needed is for map_event_to_counter() to check 
> > to see which counters are available and mark the others as unavailable
> 
> Thanks for the explanation. Can you please fix it and release a new version? 
> Documentation/Changes could be adapted then.
> 

Meanwhile we should restore the NMI counter to fix this bug.
