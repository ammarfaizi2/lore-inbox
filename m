Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbQKFKGj>; Mon, 6 Nov 2000 05:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKFKGa>; Mon, 6 Nov 2000 05:06:30 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:56842 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129040AbQKFKGU>;
	Mon, 6 Nov 2000 05:06:20 -0500
Message-ID: <3A068276.596F8003@mandrakesoft.com>
Date: Mon, 06 Nov 2000 05:05:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Paul Gortmaker <p_gortmaker@yahoo.com>,
        "David S. Miller" <davem@redhat.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0
In-Reply-To: Your message of "Sun, 05 Nov 2000 14:39:43 +1100."
				             <9277.973395583@ocs3.ocs-net> <9368.973396061@ocs3.ocs-net> <3A054872.8D88EF95@uow.edu.au> <3A06155C.796995DD@yahoo.com> <3A068025.38D62785@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would just rather clean up the drivers manually.  There's no
substitute for the human brain, and there are usually some associated
cleanups you can take care of, while working on the primary task.

I'm much more concerned about the interface.  We need to get that nailed
down and reviewed.  Once DaveM and you and Keith are all happy with the
net_device module stuff, apply that patch.  The drivers can be trivially
cleaned up.  With the latest patch I've seen, there is no -need- to
immediately update the drivers.  Once the patch is applied, I can clean
the drivers while I'm cleaning up request_region and the other stuff.

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
