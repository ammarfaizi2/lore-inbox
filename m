Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUJNWD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUJNWD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUJNUqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:46:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62592 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267170AbUJNSr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:47:27 -0400
Date: Thu, 14 Oct 2004 14:46:35 -0400
From: Dave Jones <davej@redhat.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules?
Message-ID: <20041014184635.GD18321@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	David Howells <dhowells@redhat.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	"Rusty Russell (IBM)" <rusty@au1.ibm.com>,
	David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Joy Latten <latten@us.ibm.com>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <16349.1097752!349@redhat.com> <17271.1097756056@redhat.com> <Pine.LNX.4.53.0410140824490.363@chaos.analogic.com> <Pine.GSO.4.61.0410141617100.21062@waterleaf.sonytel.be> <Pine.LNX.4.53.0410141022180.1018@chaos.analogic.com> <Pine.LNX.4.53.0410141131190.7061@chaos.analogic.com> <20041014155030.GD26025@redhat.com> <Pine.LNX.4.61.0410141352590.8479@chaos.analogic.com> <20041014182052.GA18321@redhat.com> <Pine.LNX.4.61.0410141422530.1765@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410141422530.1765@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 02:30:08PM -0400, Richard B. Johnson wrote:

 > No. I didn't time `make modules`, only `make bzImage`.
 > `make modules` takes too long to time (really) I don't
 > want to use any CPU resources which will screw up the
 > timing and I need to use the computer.

You still have to calculate dependancies and such for
anything built modular. Also a bunch of code built into
the bzImage changes if things are built modular.

the two comparisons aren't equal.  Additionally,
you haven't factored in the fact that 'make dep'
is no longer needed. This accounts for a big chunk
of time on 2.4 kernel builds.

 > A wall-clock guess is that `make modules` takes about
 > an hour on the new system while it takes about 4 minutes
 > on the old. The new kernel build procedure is truly
 > horrible for the wall-clock time that is used.
 > 
 > For oranges vs oranges, if I compile Version 2.4.26
 > on a version 2.6.8 OS computer, the compile-time
 > is within tens of seconds. I'm not complaining about
 > the resulting kernel code performance, only the
 > abortion^M^M^M^M^M^Mjunk used to create a new kernel.
 > It 'make' won't do it, we have a problem and make
 > needs to be fixed.

oranges to oranges means _exactly_ the same options
(where they haven't changed from 2.4 -> 2.6) are
set/unset. Anything else is totally bogus.

If you find things are still taking phenomenally
long times to build, then something is wrong somewhere.
Don't you find it strange you're the only person
to have complained about this ? If it was as big
a problem as you're suggesting, those of us who
do nothing but build kernels all day would be up in arms.

		Dave

