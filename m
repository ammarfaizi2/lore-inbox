Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261314AbTCJNtD>; Mon, 10 Mar 2003 08:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbTCJNtD>; Mon, 10 Mar 2003 08:49:03 -0500
Received: from pop.gmx.de ([213.165.64.20]:10427 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261314AbTCJNtC>;
	Mon, 10 Mar 2003 08:49:02 -0500
Message-Id: <5.2.0.9.2.20030310145041.00c84bc0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 10 Mar 2003 15:04:15 +0100
To: tomlins@cam.org, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.64-mm2->4 hangs on contest
In-Reply-To: <20030310124300.87756D1E@oscar.casa.dyndns.org>
References: <fa.ie98jja.2hkdj6@ifi.uio.no>
 <fa.j59micm.1fhqe9k@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:43 AM 3/10/2003 -0500, Ed Tomlinson wrote:
>Mike Galbraith wrote:
>
> > At 09:31 PM 3/10/2003 +1100, Con Kolivas wrote:
> >>On Mon, 10 Mar 2003 21:31, Mike Galbraith wrote:
> >> > Ahem.  Attached this time.
> >>
> >>I assume this is against bk? I'll massage it into 2.5.64-mm4
>
>Suspect that the interactivity changes have make the problem that my
>ptg patch is designed to fix easier to hit.

I think the problem I'm hitting is that the HUGE context switching that 
irman does causes the process load proggies to constantly max out their 
sleep average.  There are no threads involved in irman, it's just plain old 
fork().

         -Mike 

