Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbUCAI3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUCAI3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:29:23 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:39882 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262277AbUCAI3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:29:19 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@ucw.cz>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [Kgdb-bugreport] [PATCH][3/3] Update CVS KGDB's wrt connect / detach
Date: Mon, 1 Mar 2004 13:59:05 +0530
User-Agent: KMail/1.5
Cc: kernel list <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
References: <20040225213626.GF1052@smtp.west.cox.net> <20040226144155.GQ1052@smtp.west.cox.net> <20040226214531.GA397@elf.ucw.cz>
In-Reply-To: <20040226214531.GA397@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403011359.05377.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 Feb 2004 3:15 am, Pavel Machek wrote:
> Hi!
>
> > > 3. putpacket writes the packet and waits for a '+'
> > > 4. new gdb sends a protocol initialization packet
> > > 5. putpacket reads characters in that packet hoping for an incoming '+'
> > > sending out console message packet on each incoming character
> > > 6. gdb receives and rejects each console message packet
> > >
> > > > - Remove ok_packet(), excessive, IMHO.
> > >
> > > ok_packet is better than littering "OK" all over the place.
> >
> > I disagree.  If ok_packet was anything more than
> > strcpy(remcom_out_buffer, "OK") you'd be right.
>
> Amit, he's right, having function just for one strcpy only makes code
> harder to read. And it does not even save much typing...

OK. I agree that strcpy is better.

-Amit

>
> 	ok_packet(foo);
> 	strcpy(foo,"OK");
>
> ...we are talking 2 or 3 characters here....
> 								Pavel

