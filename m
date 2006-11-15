Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030910AbWKOTM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030910AbWKOTM2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030909AbWKOTM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:12:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12731 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030907AbWKOTM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:12:26 -0500
Date: Wed, 15 Nov 2006 11:07:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, discuss@x86-64.org,
       William Cohen <wcohen@redhat.com>, Eric Dumazet <dada1@cosmosbay.com>,
       Komuro <komurojun-mbn@nifty.com>, Ernst Herzberg <earny@net4u.de>,
       Andre Noll <maan@systemlinux.org>, oprofile-list@lists.sourceforge.net,
       Jens Axboe <jens.axboe@oracle.com>,
       linux-usb-devel@lists.sourceforge.net, phil.el@wanadoo.fr,
       Adrian Bunk <bunk@stusta.de>, Ingo Molnar <mingo@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>,
       Prakash Punnoor <prakash@punnoor.de>, Len Brown <len.brown@intel.com>,
       Alex Romosan <romosan@sycorax.lbl.gov>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [discuss] Re: 2.6.19-rc5: known regressions (v3)
In-Reply-To: <200611151945.31535.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0611151105560.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <200611151748.05989.ak@suse.de>
 <20061115103915.46a70283.akpm@osdl.org> <200611151945.31535.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Nov 2006, Andi Kleen wrote:
> > 
> > Meanwhile we should restore the NMI counter to fix this bug.
> 
> No, it was always oprofile who was buggy here, silently taking 
> the nmi watchdog away.

Andi, your "blame game" doesn't matter.

The fact is, it used to work, and the kernel changed interfaces, so now it 
doesn't. 

In other words, a kernel interface to user land changed. THAT IS ALWAYS A 
BUG. We don't change UI.

Yes, "oprofile" should be fixed to not depend on that, but the kernel 
shouldn't change the interfaces, and we should add back the zero entry.

		Linus
