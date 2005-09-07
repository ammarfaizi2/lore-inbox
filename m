Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVIGOMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVIGOMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 10:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVIGOMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 10:12:55 -0400
Received: from port-212-202-160-2.static.qsc.de ([212.202.160.2]:29453 "EHLO
	imr-mail.intra.in-medias-res.com") by vger.kernel.org with ESMTP
	id S1751217AbVIGOMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 10:12:55 -0400
Message-ID: <431EF5CD.9050006@in-medias-res.com>
Date: Wed, 07 Sep 2005 16:14:37 +0200
From: =?ISO-8859-15?Q?sch=F6nfeld_/_in-medias-res?= 
	<schoenfeld@in-medias-res.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
References: <S932080AbVIGI45/20050907085657Z+286@vger.kernel.org>	 <431ECA16.8040104@in-medias-res.com> <1126095079.28456.18.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1126095079.28456.18.camel@imp.csi.cam.ac.uk>
X-Enigmail-Version: 0.92.0.0
X-SA-Exim-Connect-IP: 192.168.2.172
X-SA-Exim-Mail-From: schoenfeld@in-medias-res.com
Subject: Re: ncpfs: Connection invalid / Input-/Output Errors
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.499990, version=0.92.1
   int  cnt   prob  spamicity histogram
  0.00   12 0.015404 0.009607 ############
  0.10    0 0.000000 0.009607 
  0.20    0 0.000000 0.009607 
  0.30    0 0.000000 0.009607 
  0.40    0 0.000000 0.009607 
  0.50    0 0.000000 0.009607 
  0.60    0 0.000000 0.009607 
  0.70    0 0.000000 0.009607 
  0.80    0 0.000000 0.009607 
  0.90    9 0.992764 0.488872 #########
X-SA-Exim-Version: 4.0 (built Mon, 19 Jul 2004 17:01:11 +0200)
X-SA-Exim-Scanned: Yes (on imr-mail.intra.in-medias-res.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for your answere.

Anton Altaparmakov schrieb:
> Are you using IPX or TCP/IP or UDP?  Are you using the same on both?

Sorry missed pointing that out. We are using IPX. I don't think it'll
be that easy to switch to anything other :/

> Are the two boxes in the same place and on the same connection/the same
> speed?  For example if one box is sitting close to the netware server
> and the other further away, on a congested network, it is much more
> likely to loose the connection.  

Both systems are local and therefore thats not the difference,
between them.

> Also IPX is much worse than UDP.  Our connection loss
> problems decreased a lot when we moved from IPX to UDP.
> Haven't had much experience with TCP/IP yet.  Also so far we have not
> seen any connection loss problems since we switched from 2.4 to 2.6
> kernels (suse 9.3, i.e. 2.6.11.4-21.9).

Well i can imagine that IPX is much worse than UDP ("IPX just sucks").
Unfortunately it doesn't seem to be that easy to switch that system
over to UDP, cause the Novell Server is in center of a whole system,
which has to be highly available, so we don't want to touch it.

> One of the reasons for a connection disappearing is that the NCP
> sequence numbers on the netware server and the linux client become out
> of sync.  When the netware server detects this it shuts down the
> connetion.  Linux can't do reconnects so you get exactly the errors you
> see and the connection is gone.  The fix is to umount and to mount again
> when this happens.

Uhmm... then remains the question: Why should that happen on the first
machine but not on the second?


> To see if this is your problem, insert some printk()s in the relevant
> ncpfs code (depends whether you are using ipx or tcp/udp as to where)

Well - i'm using IPX. So where do i insert the printk()s? And what kind
of printk()s should i insert? Please don't think of me as an idiot,
but i'm just not firm with "kernel hacking".

> Hope this is useful.

A little bit. Thanks anywaysw

Greets
Patrick
