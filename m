Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261531AbTCOUCO>; Sat, 15 Mar 2003 15:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261532AbTCOUCN>; Sat, 15 Mar 2003 15:02:13 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:50109 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261531AbTCOUCL>; Sat, 15 Mar 2003 15:02:11 -0500
Message-Id: <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: dan carpenter <d_carpenter@sbcglobal.net>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Any hope for ide-scsi (error handling)?
Date: Sat, 15 Mar 2003 03:52:21 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "" <wrlk@riede.org>
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com> <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net> <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 March 2003 08:53 pm, Zwane Mwaikambo wrote:
> On Sat, 15 Mar 2003, dan carpenter wrote:
> > On Saturday 15 March 2003 07:55 pm, Zwane Mwaikambo wrote:
> > > bad: scheduling while atomic!
> > > Call Trace:
> >
> >    887          spin_lock_irqsave(&ide_lock, flags);
> >    888          while (HWGROUP(drive)->handler) {
> >    889                  HWGROUP(drive)->handler = NULL;
> >    890                  schedule_timeout(1);
> >    891          }
> >
> > Here is at least one bad call to schedule() in
> > static int idescsi_reset (Scsi_Cmnd *cmd)
>
> Apart from the schedule with the ide_lock held, what is that code actually
> doing?
>
> 	Zwane

Hm...  Good question.  I have no idea what the while loop is for.

regards,
dan carpenter
