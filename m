Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWBVUlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWBVUlO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWBVUlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:41:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48576 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751411AbWBVUlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:41:13 -0500
Date: Wed, 22 Feb 2006 12:40:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mattia Dongili <malattia@linux.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1 console (radeonfb) not resumed after s2ram
Message-Id: <20060222124041.0f3a8538.akpm@osdl.org>
In-Reply-To: <20060222193922.GA4372@inferi.kami.home>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	<20060221190031.GA3531@inferi.kami.home>
	<20060221134323.6a5e5a95.akpm@osdl.org>
	<17679.217.33.203.18.1140618278.squirrel@picard.linux.it>
	<20060222193922.GA4372@inferi.kami.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattia Dongili <malattia@linux.it> wrote:
>
> On Wed, Feb 22, 2006 at 03:24:38PM +0100, Mattia Dongili wrote:
> > On Tue, February 21, 2006 10:43 pm, Andrew Morton said:
> > > Mattia Dongili <malattia@linux.it> wrote:
> > >>
> > >> On Mon, Feb 20, 2006 at 04:26:15AM -0800, Andrew Morton wrote:
> > >> >
> > >> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/
> > >>
> > >> After suspend the system is fully working except it doesn't resume the
> > >> console (I'm using radeonfb). If suspending from X the thing comes back,
> > >> X working ok, but switching to vt1 I see the console completely garbled.
> > >> Reverting radeonfb-resume-support-for-samsung-p35-laptops.patch (_wild_
> > >> guess) does not help.
> > >> Any good candidate?
> > >
> > > Did you apply the patches in the hot-fixes directory?
> > > revert-reset-pci-device-state-to-unknown-after-disabled.patch might help.
> > 
> > Sorry, this didn't help either. I'll try to revert some suspend related
> > patches then go bisecting if still unsuccessful.
> 
> Ok, reverting the same 4 patches as suggested to Rafael J. Wysocki
> restores the correct behaviour:
> 
> pm-add-state-field-to-pm_message_t-to-hold-actual.patch
> pm-respect-the-actual-device-power-states-in-sysfs.patch
> pm-minor-updates-to-core-suspend-resume-functions.patch
> pm-make-pci_choose_state-use-the-real-device.patch
> 
> Are they indipendent? Would you want me to track the exact one
> introducing the bug?
> 

Is OK, thanks - I have already passed that info on to Pat and I dropped all
four.

