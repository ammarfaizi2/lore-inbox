Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265942AbUAEWBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUAEWBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:01:11 -0500
Received: from aun.it.uu.se ([130.238.12.36]:47345 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265942AbUAEWBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:01:00 -0500
Date: Mon, 5 Jan 2004 23:00:57 +0100 (MET)
Message-Id: <200401052200.i05M0vnm002436@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: wrlk@riede.org
Subject: Re: The survival of ide-scsi in 2.6.x
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003 13:12:42 -0500, Willem Riede wrote:
>I know that many feel that ide-scsi is useless, and should go away.
>And you are probably tired of message threads talking about it.
>Yet I ask respectfully that you hear me out, and give me feedback.
>
>I need ide-scsi to survive. Why? I maintain osst, a driver for
>OnStream tape drives, which need special handling. These drives
...
>So can we agree to keep ide-scsi? I know it is not desired any
>more for cd writers. To avoid the problem reports from people who
>don't realize that and select ide-scsi anyway, we can refuse to
>attach to a cd-type device (today it just warns). And/or make a 
>new explicit module parameter to tell ide-scsi exactly which 
>drives to attach to.

I have a simple patch to do exactly that. Contact me if you want it.

>Linus states in [7] that ide-scsi needs a maintainer. I haven't seen 
>anyone step forward, so that leads me to believe I may be the only 
>person that depends enough on ide-scsi to be motivated?
>
>If people will have me, I am prepared to take on that responsibility.
>I am just concerned that I may not have enough of a variety of devices
>to be able to thoroughly test it (unless the DI-30 is the only one :-)).

I use ide-scsi + st for my Seagate ATAPI tape drive, so I welcome
your initiative. ide-tape has had many reliability problems in the
2.4 kernels, and the 2.5 bio changes left it broken from 2.5.12 or
so to 2.6.0-test<late>. It may have been repaired lately, but I for
one don't trust that code base any more.

/Mikael
