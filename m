Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQLGCt3>; Wed, 6 Dec 2000 21:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129688AbQLGCtS>; Wed, 6 Dec 2000 21:49:18 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:2831 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129464AbQLGCtC>; Wed, 6 Dec 2000 21:49:02 -0500
Date: Wed, 6 Dec 2000 20:14:36 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: Re: 2.2.18-24 intermittent PS/2 mouse problems
Message-ID: <20001206201436.A15470@vger.timpanogas.org>
In-Reply-To: <20001206201019.A15457@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001206201019.A15457@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Wed, Dec 06, 2000 at 08:10:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 08:10:19PM -0700, Jeff V. Merkey wrote:
> 
> 
> Alan,
> 
> I am still seeing intermittent mouse problems with a PS2 mouse on a 
> 4 x PPro box with 2.2.18-24.  When the system is first powered up, 
> the mouse detection is working great.  If I reboot the machine without
> powering it down, about 1 in 3 times I do this, the next kernel load
> fails to detect the mouse.  I have not looked at the driver to see
> what state the Mouse port is in, but could.  
> 
> Is there something I could do to help you debug this problem (i.e.
> is there somewhere in the kernel code I should put in some 
> sanity checking to see if the mouse is being left in a good state.
> 
> Powering down the machine makes the problem go away.  Does not happen
> on 2.4.0-12, BTW, just 2.2.18-24.
> 
> Jeff


Alan,

One more thing.  I was able to reproduce it once during an initial powerup
sequence by putzing with the mouse buttons while the auto-detection was going
on (generating interrupts?).  I am wondering if the problem in in the way 
interrupts are being handled for the mouse.  If I leave the mouse alone 
it seems to get autodetected properly.

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
