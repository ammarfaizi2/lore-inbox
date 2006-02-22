Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWBVTl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWBVTl0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWBVTlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:41:25 -0500
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]:37065 "EHLO
	aa005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751312AbWBVTlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:41:25 -0500
Date: Wed, 22 Feb 2006 20:39:23 +0100
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1 console (radeonfb) not resumed after s2ram
Message-ID: <20060222193922.GA4372@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060220042615.5af1bddc.akpm@osdl.org> <20060221190031.GA3531@inferi.kami.home> <20060221134323.6a5e5a95.akpm@osdl.org> <17679.217.33.203.18.1140618278.squirrel@picard.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17679.217.33.203.18.1140618278.squirrel@picard.linux.it>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc4-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 03:24:38PM +0100, Mattia Dongili wrote:
> On Tue, February 21, 2006 10:43 pm, Andrew Morton said:
> > Mattia Dongili <malattia@linux.it> wrote:
> >>
> >> On Mon, Feb 20, 2006 at 04:26:15AM -0800, Andrew Morton wrote:
> >> >
> >> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/
> >>
> >> After suspend the system is fully working except it doesn't resume the
> >> console (I'm using radeonfb). If suspending from X the thing comes back,
> >> X working ok, but switching to vt1 I see the console completely garbled.
> >> Reverting radeonfb-resume-support-for-samsung-p35-laptops.patch (_wild_
> >> guess) does not help.
> >> Any good candidate?
> >
> > Did you apply the patches in the hot-fixes directory?
> > revert-reset-pci-device-state-to-unknown-after-disabled.patch might help.
> 
> Sorry, this didn't help either. I'll try to revert some suspend related
> patches then go bisecting if still unsuccessful.

Ok, reverting the same 4 patches as suggested to Rafael J. Wysocki
restores the correct behaviour:

pm-add-state-field-to-pm_message_t-to-hold-actual.patch
pm-respect-the-actual-device-power-states-in-sysfs.patch
pm-minor-updates-to-core-suspend-resume-functions.patch
pm-make-pci_choose_state-use-the-real-device.patch

Are they indipendent? Would you want me to track the exact one
introducing the bug?

-- 
mattia
:wq!
