Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129498AbRCBVPj>; Fri, 2 Mar 2001 16:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129502AbRCBVP3>; Fri, 2 Mar 2001 16:15:29 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:64451 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129498AbRCBVPV>;
	Fri, 2 Mar 2001 16:15:21 -0500
Message-ID: <3AA00D5A.44FA21D0@mandrakesoft.com>
Date: Fri, 02 Mar 2001 16:15:06 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-4mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
Cc: pat@isis.co.za, linux-kernel@vger.kernel.org, Alan@redhat.com,
        Donald Becker <becker@scyld.com>
Subject: Re: PROBLEM: Network hanging - Tulip driver with Netgear (Lite-On)
In-Reply-To: <3A9A30C7.3C62E34@colorfullife.com> <3A9AB84C.A17D20AE@mandrakesoft.com> <3A9AC372.A86DC6C7@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Could you double check the code in tulip_core.c, around line 1450?
> IMHO it's bogus.
> 
> 1) if the network card contains multiple mii's, then the the advertised
> value of all mii's is changed to the advertised value of the first mii.

I'm really curious about this one myself.

Since I haven't digested all of the tulip media stuff in my brain yet,
and since I'm not familiar with all the corner cases, I'm loathe to
change the tulip media stuff without fully understanding what's going
on.

If you have a single controller with multiple MII phys...  how does one
select the phy of choice (for tulip, in the absence of SROM media
table...)?  And once phy A has been selected out of N available as the
active phy, should you care about the others at all?

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
