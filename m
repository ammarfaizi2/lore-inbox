Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWGaEWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWGaEWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWGaEWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:22:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54672 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751449AbWGaEWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:22:33 -0400
Date: Sun, 30 Jul 2006 21:22:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       laurent.riffard@free.fr, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
Message-Id: <20060730212227.175c844c.akpm@osdl.org>
In-Reply-To: <20060731033757.GA13737@kroah.com>
References: <20060727015639.9c89db57.akpm@osdl.org>
	<44CCBBC7.3070801@free.fr>
	<20060731000359.GB23220@kroah.com>
	<200607302227.07528.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<20060731033757.GA13737@kroah.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006 20:37:57 -0700
Greg KH <greg@kroah.com> wrote:

> On Sun, Jul 30, 2006 at 10:27:06PM -0400, Andrew James Wade wrote:
> > On Sunday 30 July 2006 20:03, Greg KH wrote:
> > > Something's really broken with that version of udev then, because the
> > > 094 version I have running here works just fine with these symlinks.
> > 
> > Maybe, but some really odd things were happening in /sys with the
> > patch. I could still follow the bogus symlinks. More than that
> > 
> > /sys/class/mem/mem$ cd ../../class
> > and
> > /sys/class/mem/mem$ cd ../..
> > 
> > _both_ ended up with a $PWD of /sys/class.
> 
> Ick, ok, the problem is that my "virtual device" patch isn't in my
> "public" patch set that Andrew pulls from.  It will fix this issue up.
> I'll work on cleaning it up to be used by everyone tomorrow and move it
> to the tree that Andrew pulls from.  Then the next -mm release should
> have this issue fixed.

Mutter.  This stuff breaks my FC3 test box and there is, afaict, no clear
way for users to upgrade udev to unbreak it.

As a developer I could of course bang on things until it works, but that's
not the point.  The point is that these patches break Linux on a major
release from a major vendor only two years after its release.  That's not a
minor problem, is it?
