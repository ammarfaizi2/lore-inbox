Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTCDW31>; Tue, 4 Mar 2003 17:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbTCDW31>; Tue, 4 Mar 2003 17:29:27 -0500
Received: from buitenpost.surfnet.nl ([192.87.108.12]:16786 "EHLO
	buitenpost.surfnet.nl") by vger.kernel.org with ESMTP
	id <S261660AbTCDW30>; Tue, 4 Mar 2003 17:29:26 -0500
Date: Tue, 4 Mar 2003 23:39:53 +0100
To: Brian Litzinger <brian@top.worldcontrol.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting 2.5.63 vs 2.4.20 I can't read multicast data
Message-ID: <20030304223953.GA3114@pangsit>
References: <20030304073939.GA31394@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030304073939.GA31394@top.worldcontrol.com>
X-Mailer: Mutt on Debian GNU/Linux sid
X-Editor: vim
X-Organisation: SURFnet bv
X-Address: Radboudburcht, P.O. Box 19035, 3501 DA Utrecht, NL
X-Phone: +31 302 305 305
X-Telefax: +31 302 305 329
User-Agent: Mutt/1.5.3i
From: Niels den Otter <otter@surfnet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On Monday,  3 March 2003, brian@worldcontrol.com wrote:
> I give the 2.5 series a try every once in a while and found the 2.5.63
> booted and ran reasonably well.
> 
> I happen to working on some multicast stuff and found that I can't
> read multicast data when running 2.5.63.
> 
> Switched back to 2.4.20 and the multicast data reads fine.
> 
> Back to 2.5.63 and nada.  tcpdump shows the data showing up
> at the interface.  I double checked the obvious stuff like
> multicast being turned on in the kernel.
> 
> I even have tulip and rtl-8139 based cards I can switch between
> and that made no difference either.
> 
> Is there something I have to set someplace to get multicast support in
> 2.5.x?

You appear to be strugling with the same problem I have. What I find is
that the multicast application binds to the loopback instead of ethernet
interface (also no IGMP joins are send out on the ethernet interface).
Can you please check the output of 'netstat -n -g' and see if the
multicast address shows up at the correct interface?

Various people have provided hints on how (and in what order) to setup
the interfaces, but uptil now I have not been able to receive any
multicast data with 2.5 kernels.

It would be nice to know if anyone is able to join multicast groups on
2.5 kernels. Especially for applications that don't bind to a very
specific interface, but leave this choice to the kernel.


-- Niels
