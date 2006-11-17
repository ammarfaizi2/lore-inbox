Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755661AbWKQKSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbWKQKSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 05:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755662AbWKQKSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 05:18:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34766 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755660AbWKQKSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 05:18:15 -0500
Date: Fri, 17 Nov 2006 02:13:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: ebiederm@xmission.com (Eric W. Biederman), Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       William Cohen <wcohen@redhat.com>, Komuro <komurojun-mbn@nifty.com>,
       Ernst Herzberg <earny@net4u.de>, Andre Noll <maan@systemlinux.org>,
       oprofile-list@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>,
       linux-usb-devel@lists.sourceforge.net, phil.el@wanadoo.fr,
       Adrian Bunk <bunk@stusta.de>, Ingo Molnar <mingo@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>,
       Prakash Punnoor <prakash@punnoor.de>, Len Brown <len.brown@intel.com>,
       Alex Romosan <romosan@sycorax.lbl.gov>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [discuss] Re: 2.6.19-rc5: known regressions (v3)
Message-Id: <20061117021357.bcdbe52c.akpm@osdl.org>
In-Reply-To: <17757.34795.689658.106603@alkaid.it.uu.se>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<200611151945.31535.ak@suse.de>
	<Pine.LNX.4.64.0611151105560.3349@woody.osdl.org>
	<200611152023.53960.ak@suse.de>
	<20061115122118.14fa2177.akpm@osdl.org>
	<m18xic4den.fsf@ebiederm.dsl.xmission.com>
	<20061115133121.8d9d621f.akpm@osdl.org>
	<17756.17330.974883.486535@alkaid.it.uu.se>
	<20061116122358.996fdbb3.akpm@osdl.org>
	<17757.34795.689658.106603@alkaid.it.uu.se>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 10:59:07 +0100
Mikael Pettersson <mikpe@it.uu.se> wrote:

> Andrew Morton writes:
>  > On Thu, 16 Nov 2006 11:55:46 +0100
>  > Mikael Pettersson <mikpe@it.uu.se> wrote:
>  > 
>  > > Andrew Morton writes:
>  > >  > Surely the appropriate behaviour is to allow oprofile to steal the NMI and
>  > >  > to then put the NMI back to doing the watchdog thing after oprofile has
>  > >  > finished with it.
>  > > 
>  > > Which is _exactly_ what pre-2.6.19-rc1 kernels did. I implemented
>  > > the in-kernel API allowing real performance counter drivers like
>  > > oprofile (and perfctr) to claim the HW from the NMI watchdog,
>  > > do their work, and then release it which resumed the watchdog.
>  > 
>  > OK.  But from Andi's comments it seems that the NMI watchdog was failing to
>  > resume its operation.
> 
> It certainly worked when I originally implemented it. If it didn't work
> that way before 2.6.19-rc1 butchered it then that would have been a bug
> that should have been fixed.

Oh.  OK.

Meanwhile, 2.6.19-rc6 remains unfixed.

