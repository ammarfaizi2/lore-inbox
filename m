Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbTCJNaI>; Mon, 10 Mar 2003 08:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbTCJNaI>; Mon, 10 Mar 2003 08:30:08 -0500
Received: from tomts24.bellnexxia.net ([209.226.175.187]:61386 "EHLO
	tomts24-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261310AbTCJNaI>; Mon, 10 Mar 2003 08:30:08 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64-mm2->4 hangs on contest
Date: Mon, 10 Mar 2003 08:41:01 -0500
User-Agent: KMail/1.5.9
References: <fa.ie98jja.2hkdj6@ifi.uio.no> <fa.j59micm.1fhqe9k@ifi.uio.no> <5.2.0.9.2.20030310144020.00c8feb0@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030310144020.00c8feb0@pop.gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303100841.01165.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 10, 2003 08:41 am, Mike Galbraith wrote:
> At 07:43 AM 3/10/2003 -0500, Ed Tomlinson wrote:
> >Mike Galbraith wrote:
> > > At 09:31 PM 3/10/2003 +1100, Con Kolivas wrote:
> > >>On Mon, 10 Mar 2003 21:31, Mike Galbraith wrote:
> > >> > Ahem.  Attached this time.
> > >>
> > >>I assume this is against bk? I'll massage it into 2.5.64-mm4
> >
> >Suspect that the interactivity changes have make the problem that my
> >ptg patch is designed to fix easier to hit.  Con where is the latest
> >contest (a quick google does not help)?  Mike what version of irman
> >are you using?  The one I have has problems parsing /proc/mem in mm.
>
> Version 0.5.  (also has parse problem)

If you guys play with the ptg patch there are two tunables you should
be aware of.  The first is theard_governor, which probably will not need
to be touched.  The second is user_governor.  This one you may want to 
reduce from 100 to 50 - meaning start reducing a user's timeslices when
there are more than 5 in run queue tasks for that user.

Ed

