Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129504AbQKQXKu>; Fri, 17 Nov 2000 18:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129859AbQKQXKk>; Fri, 17 Nov 2000 18:10:40 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:18959 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129504AbQKQXK3>;
	Fri, 17 Nov 2000 18:10:29 -0500
Message-ID: <3A15B3DA.89124F2C@mandrakesoft.com>
Date: Fri, 17 Nov 2000 17:40:26 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: davem@redhat.com, linux-kernel@vger.kernel.org, willy@meta-x.org,
        wtarreau@yahoo.fr
Subject: Re: sunhme.c patch for new PCI interface (UNTESTED)
In-Reply-To: <200011172215.OAA06687@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> Jeff Garzik writes:
> >Are you aware of any hotplug sunhme hardware?  If no, don't change it to
> >__devinit...
> 
>         Can I have a hot plug PCI bridge card that connects to
> a regular PCI backplane (perhaps as some kind of CardBus docking
> station card)?  If so, all PCI drivers should use __dev{init,exit}{,data}.

I am willing to consider adding __devxxx only when other __devxxx
entries already exist.

These conversions to _devxxx are too late in the freeze, and only have
value for isolated cases --which you admit you don't even know exist--. 
Linus Rule 1: Don't overdesign.  Even if such cases do exist, and this
is a need, it should be addressed some other way.

Your suggestion bloats drivers needlessly for the majority of cases and
I will not be applying any such patches...

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
