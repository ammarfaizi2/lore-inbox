Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWHIBms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWHIBms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWHIBmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:42:47 -0400
Received: from colin.muc.de ([193.149.48.1]:11789 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030412AbWHIBmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:42:47 -0400
Date: 9 Aug 2006 03:42:45 +0200
Date: Wed, 9 Aug 2006 03:42:45 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Message-ID: <20060809014245.GA59180@muc.de>
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net> <6bffcb0e0608081329r732e191dsec0f391ea70f7d28@mail.gmail.com> <20060808140511.def9b13c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808140511.def9b13c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 02:05:11PM -0700, Andrew Morton wrote:
> On Tue, 8 Aug 2006 22:29:03 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> 
> > Hi Andrew,
> > 
> > On 08/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> > > The mm snapshot broken-out-2006-08-08-00-59.tar.gz has been uploaded to
> > >
> > >    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-08-00-59.tar.gz
> > >
> > > It contains the following patches against 2.6.18-rc4:
> > 
> > It appears very early. 2.6.18-rc3-mm2 was fine.
> > 
> > DWARF2 unwinder stuck at error_code+0x39/0x40
> 
> The novelty of this thing has worn off.  Guys, please let's not release 2.6.18 in
> this state.

The stucks are harmless (and currently expected) as long as the 
dwarf2 trace and the leftover trace give you a full picture
and the unwinder doesn't crash (the later would be a bug that needs
to be fixed before)

I have various fixed queued for the unwinder (or rather
for annotations used by the unwinder), but expect them
to only be merged with .19.

> 
> > Leftover inexact backtrace
> > [<c0104194>] show_stack_log_lvl+0x8c/0x97

This might be ok.

> > [<c0104320>] show_registers+0x181/0x215
> > [<c0104576>] die+0x1c2/0x2dd
> > [<c0117419>] do_page_fault+ox410/0x4f3
> > [<c02f5271>] error_code+0x39/0x40
> > [<c0104194>] show_stack_log_lvl+0x8c/0x97
> > [<c0104320>] show_registers+0x181/0x215
> > [<c0104576>] die+0x1c2/0x2dd
> > [<c0117419>] do_page_fault+0x410/0x4f3
> > [<c02f5271>] error_code+0x39/0x40
> > [<c047b609>] start_kernel+0x224/0x3a2
> > [<c0100210>] 0xc0100210
> > Code: 00 39 .......
> > EIP:[<c01040ca>] show_trace_log_lvl+0x11b/0x159 SS:ESP 0068:c0479e74

This might be not. Hard to tell. Can we have a complete oops please?
(using netconsole or digital camera or firescope) 

-andi
