Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760666AbWLFOtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760666AbWLFOtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 09:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760667AbWLFOtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 09:49:20 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:33927 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760666AbWLFOtU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 09:49:20 -0500
Subject: Re: [PATCH 0/3] New firewire stack
From: Ben Collins <ben.collins@ubuntu.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <457685D1.1080501@s5r6.in-berlin.de>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
	 <20061205184921.GA5029@martell.zuzino.mipt.ru>
	 <4575FF08.2030100@redhat.com> <1165383349.7443.78.camel@gullible>
	 <457685D1.1080501@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Date: Wed, 06 Dec 2006 09:49:06 -0500
Message-Id: <1165416546.7443.111.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-06 at 09:56 +0100, Stefan Richter wrote:
> (Adding Cc: linux1394-devel)
> 
> Ben Collins wrote at linux-kernel:
> > On Tue, 2006-12-05 at 18:21 -0500, Kristian Høgsberg wrote:
> >> Alexey Dobriyan wrote:
> >>> On Tue, Dec 05, 2006 at 12:22:29AM -0500, Kristian Høgsberg wrote:
> >>>> I'm announcing an alternative firewire stack that I've been working on 
> >>>> the last few weeks.
> >>> Is mainline firewire so hopeless, that you've decided to rewrite it? Could
> >>> you show some ugly places in it?
> >> Yes.  I'm not doing this lightheartedly.  It's a lot of work and it will
> >> introduce regressions and instability for a little while.
> >>
> >> My main point about ohci1394 (the old stacks PCI driver) is, that if you
> >> really want to fix the issues with this driver, you have to shuffle the code
> >> around so much that you'll introduce as many regressions as a clean rewrite.
> >> The big problems in the ohci1394 drivers is the irq_handler, bus reset
> >> handling and config rom handling.  These are some of the strong points of
> >> fw-ohci.c:
> > 
> > My main concern is that when I picked up ieee1394 maint myself, it was
> > because it was not big-endian or 64-bit friendly.
> 
> I would like to see new development efforts take cleanliness WRT host
> byte order and 64bit architectures into account from the ground up. (I
> understand though why Kristian made the announcement in this early
> phase, and I agree with him that this kind of development has to go into
> the open early.)

And yet endianness is not the focus from the ground up in Kristian's
work. That was my point.
