Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTCOTqL>; Sat, 15 Mar 2003 14:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261498AbTCOTqL>; Sat, 15 Mar 2003 14:46:11 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:28195
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261495AbTCOTqL>; Sat, 15 Mar 2003 14:46:11 -0500
Date: Sat, 15 Mar 2003 14:53:39 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: dan carpenter <d_carpenter@sbcglobal.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, "" <wrlk@riede.org>
Subject: Re: Any hope for ide-scsi (error handling)?
In-Reply-To: <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net>
Message-ID: <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com>
 <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Mar 2003, dan carpenter wrote:

> On Saturday 15 March 2003 07:55 pm, Zwane Mwaikambo wrote:
> >
> > bad: scheduling while atomic!
> > Call Trace:
> >
> 
>    887          spin_lock_irqsave(&ide_lock, flags);
>    888          while (HWGROUP(drive)->handler) {
>    889                  HWGROUP(drive)->handler = NULL;
>    890                  schedule_timeout(1);
>    891          }
> 
> Here is at least one bad call to schedule() in 
> static int idescsi_reset (Scsi_Cmnd *cmd)

Apart from the schedule with the ide_lock held, what is that code actually 
doing?

	Zwane
-- 
function.linuxpower.ca
