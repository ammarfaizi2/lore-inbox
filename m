Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287950AbSAOQgO>; Tue, 15 Jan 2002 11:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSAOQgE>; Tue, 15 Jan 2002 11:36:04 -0500
Received: from ns.ithnet.com ([217.64.64.10]:38674 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287950AbSAOQgC>;
	Tue, 15 Jan 2002 11:36:02 -0500
Date: Tue, 15 Jan 2002 17:35:51 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory problem with bttv driver
Message-Id: <20020115173551.5a3fc051.skraw@ithnet.com>
In-Reply-To: <20020115161653.A9550@bytesex.org>
In-Reply-To: <20020114210039.180c0438.skraw@ithnet.com>
	<E16QETz-0002yD-00@the-village.bc.nu>
	<20020115004205.A12407@werewolf.able.es>
	<slrna480cv.68d.kraxel@bytesex.org>
	<20020115121424.10bb89b2.skraw@ithnet.com>
	<20020115142017.D8191@bytesex.org>
	<20020115161653.A9550@bytesex.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002 16:16:53 +0100
Gerd Knorr <kraxel@bytesex.org> wrote:

> On Tue, Jan 15, 2002 at 02:46:52PM +0100, Stephan von Krawczynski wrote:
> > On Tue, 15 Jan 2002 14:20:17 +0100
> > Gerd Knorr <kraxel@bytesex.org> wrote:
> > 
> > > Yes.  Instead of remapping vmalloced kernel memory it gives you shared
> > > anonymous pages, then does zerocopy DMA using kiobufs.  You may run in
> > > trouble with >4GB machines.
> > 
> > Interesting.
> > What's the problem on > 4GB ?
> 
> The bt878/848 is a 32bit PCI device, it simply can't go DMA to main
> memory above 4GB.  At least on ia32, on architecures with a iommu
> (sparc, ...) it should work without trouble.

Sorry, maybe I should have clarified: what is the problem with allocating those
pages below 4GB in a >4GB box?

Regards,
Stephan

