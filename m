Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318203AbSGWUTR>; Tue, 23 Jul 2002 16:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318208AbSGWUTQ>; Tue, 23 Jul 2002 16:19:16 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:22288 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S318203AbSGWUTQ>; Tue, 23 Jul 2002 16:19:16 -0400
Date: Tue, 23 Jul 2002 16:18:09 -0400
From: Jay Estabrook <Jay.Estabrook@compaq.com>
To: George France <france@handhelds.org>
Cc: Martin Brulisauer <martin@uceb.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5.26 - arch/alpha
Message-ID: <20020723161809.B2868@linux04.mro.cpqcorp.net>
References: <3D3D6B3B.25754.1392D3FD@localhost> <3D3DA7F3.9275.1480075C@localhost> <02072315005002.31958@shadowfax.middleearth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <02072315005002.31958@shadowfax.middleearth>; from france@handhelds.org on Tue, Jul 23, 2002 at 03:00:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 03:00:50PM -0400, George France wrote:
> On Tuesday 23 July 2002 13:01, Martin Brulisauer wrote:
> >
> > Hopefully I can fix core_cia.c to run on XLT's (it's hard to find any
> > documentation on this toppic) and arch/alpha/kernel/setup.c for
> > machines booting with linload.exe/MILO because the hwrpb
> > struct is built by MILO and does not match the one booting from
> > SRM (eg. empty percpu struct resulting in a cpucount of zero
> > in /proc/cpuinfo).
> 
> I am not very familiar with the XLT systems. Maybe Jay can help.  He
> has been working on Alpha systems for a very long time.
> 
> Jay, do you have any suggestions???

Yup, use the following patches, based on pre8-2.4.19, to fix the
DMA windowing problem with the early (read: 300MHz) XLT boxes.

As for the CPU count being zero, well, aside from looking bad, what
seems to be the problem? ;-}

 --Jay++

-----------------------------------------------------------------------------
Jay A Estabrook                            HPTC - LINUX support
Hewlett-Packard Company - MRO1-2/K15       (508) 467-2080
200 Forest Street, Marlboro MA 01752       Jay.Estabrook@hp.com
-----------------------------------------------------------------------------
