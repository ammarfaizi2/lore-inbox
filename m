Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289198AbSAVIFC>; Tue, 22 Jan 2002 03:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289196AbSAVIEw>; Tue, 22 Jan 2002 03:04:52 -0500
Received: from [216.223.235.2] ([216.223.235.2]:32386 "HELO
	inventor.gentoo.org") by vger.kernel.org with SMTP
	id <S289198AbSAVIEf>; Tue, 22 Jan 2002 03:04:35 -0500
Subject: Re: Athlon PSE/AGP Bug
From: Daniel Robbins <drobbins@gentoo.org>
To: "David S. Miller" <davem@redhat.com>
Cc: andrea@suse.de, alan@redhat.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@zip.com.au>,
        Terrence Ripperda <ripperda@nvidia.com>, drobbins@gentoo.org
In-Reply-To: <20020121.230856.71191773.davem@redhat.com>
In-Reply-To: <20020122013909.N8292@athlon.random>
	<20020121.170822.32749723.davem@redhat.com>
	<20020122070517.GK135220@niksula.cs.hut.fi> 
	<20020121.230856.71191773.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 22 Jan 2002 01:05:49 -0700
Message-Id: <1011686749.7126.60.camel@inventor.gentoo.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-22 at 00:08, David S. Miller wrote:
> Yes, Gareth Hughes @ NVIDIA understands very well that this can still
> be just a heisenbug.
> 
> There is still no hard proof that not using 4M pages really fixes
> anything AMD states is wrong with their chips.

Well, it's clear that either NVIDIA, AMD or the general opinion held by
the majority Linux kernel guys is wrong.  I'm eager to find out the
truth behind the matter so that the parties involved can work towards a
solution, whatever that may be.  

It'd be a bummer if I find that the explanation that NVIDIA gave me
turns out to be false.  But it seems that there may be a real issue
here.  I have received quite a few reports (and read in quite a few
comments posted on sites) that mem=nopentium solved a variety of strange
stability-related issues related to PCI/AGP devices.  It may turn out
that the Athlon does have a problem with ends of DMA push buffers
aligned to 4Mb page boundaries.  mem=nopentium seems to have fixed audio
and other types of lock-ups as well.  Note that AMD told me on the phone
this morning that the issue Terrence found (and the AMD Windows 2000
patch was created to solve) did *not* corellate with the published AMD
errata that everyone on LKML is talking about, but was in fact another
issue.  

Thankfully, the guessing will (hopefully) soon be over. AMD will be
calling me tomorrow at 3PM MST. They've reached a conclusion as to
what's going on, and I'll post the AMD's official word on gentoo.org as
soon as I get it.

Best Regards,

-- 
Daniel Robbins                                  <drobbins@gentoo.org>
Chief Architect/President                       http://www.gentoo.org 
Gentoo Technologies, Inc.

