Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129557AbRBSQVy>; Mon, 19 Feb 2001 11:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129799AbRBSQVp>; Mon, 19 Feb 2001 11:21:45 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:19488 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129557AbRBSQVd>; Mon, 19 Feb 2001 11:21:33 -0500
Date: Mon, 19 Feb 2001 10:21:04 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, prumpf@parcelfarce.linux.theplanet.co.uk,
        rusty@linuxcare.com
Subject: Re: Linux 2.4.1-ac15
In-Reply-To: <E14UsmJ-0003kx-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1010219101008.32729A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Alan Cox wrote:
> > Rusty had a patch that locked the module list properly IIRC.
> 
> So does -ac now. I just take a spinlock for the modify cases that race
> against faults (including vmalloc faults from irq context)

so you hold a spinlock during copy_from_user ?  Or did you change
sys_init_module/sys_create_modules semantics ?

