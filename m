Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129099AbQKCViP>; Fri, 3 Nov 2000 16:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131936AbQKCViF>; Fri, 3 Nov 2000 16:38:05 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:48914 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129099AbQKCVh5>;
	Fri, 3 Nov 2000 16:37:57 -0500
Message-ID: <3A03302C.C2A87573@mandrakesoft.com>
Date: Fri, 03 Nov 2000 16:37:48 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <E13rj9s-0003c4-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> >      * Check all devices use resources properly (Everyone now has to use
> >        request_region and check the return since we no longer single
> >        thread driver inits in all module cases. Also memory regions are
> >        now requestable and a lot of old drivers dont know this yet. --
> >        Alan Cox)
> 
> Folks have done most of the common drivers. So its not really a show stopper
> now just a 'clean up'

s/check_region/request_region/ is moving along, but there is still a
ways to go.  I agree with "folks have done most of the common drivers"

I have seen very few additions of request_mem_region, though.


> >      * Issue with notifiers that try to deregister themselves? (lnz;
> >        notifier locking change by Garzik should backed out, according to
> >        Jeff)
> 
> and according to Alan

Fixed for a couple versions now.


> >      * Spin doing ioctls on a down netdeice as it unloads == BOOM
> >        (prumpf, Alan Cox) Possible other net driver SMP issues (andi
> >        kleen)
> 
> Turns out to be safe according to Jeff and ANK

To avoid Andi confusing the issue :) ...

1) The first item listed does not exist

2) the second item listed exists -- many net drivers are not SMP.  They
are most of the way there, but there are still small races which exist
in some drivers.

	Jeff



-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
