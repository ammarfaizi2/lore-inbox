Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314210AbSD0Ofu>; Sat, 27 Apr 2002 10:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314216AbSD0Oft>; Sat, 27 Apr 2002 10:35:49 -0400
Received: from gear.torque.net ([204.138.244.1]:53772 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S314210AbSD0Oft>;
	Sat, 27 Apr 2002 10:35:49 -0400
Message-ID: <3CCAB64A.C8BB5DB5@torque.net>
Date: Sat, 27 Apr 2002 10:31:38 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.9-dj1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.x-dj and SCSI error handling.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de> wrote:
>On Sat, Apr 27, 2002 at 09:48:37AM -0400, Mr. James W. Laferriere wrote:
> >      Hello Dave ,  Might be nice to also mention the drivers that were
> >      being complained about .  So there respective mantainers can
> >      benifit from your email .  Tia ,  JimL
>
>noted. I'll do a full compile later today and post back the list of
>drivers broken due to this issue. The only one everyone seems to be
>complaining about is ide-scsi, but there are definitly others.

Dave,
We only really need one of the new "eh" handlers,
either:
  eh_device_reset_handler() or
  eh_bus_reset_handler()
to be implemented in ide-scsi.c in order to go forward.
Assuming we pick the first one, perhaps someone could
tell me, from the context of ide-scsi, how to (politely) 
reset the ATAPI device it is referring to?

[A similar approach will suffice for any other scsi drivers
"broken" by the removal of abort() and reset(). Eric
Youngdale warned of their impending removal about 3 years
ago!]

Doug Gilbert
