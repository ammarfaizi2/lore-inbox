Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267129AbUBMRIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 12:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267131AbUBMRIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 12:08:45 -0500
Received: from pell.portland.or.us ([192.156.98.250]:23301 "EHLO
	pell.portland.or.us") by vger.kernel.org with ESMTP id S267129AbUBMRIo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 12:08:44 -0500
Date: Fri, 13 Feb 2004 09:08:16 -0800
From: david parsons <orc@pell.portland.or.us>
To: Nagy Tibor <nagyt@otpbank.hu>, xela@slit.de, mochel@osdl.org,
       bmoyle@mvista.com, orc@pell.chi.il.us, linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM
Message-ID: <20040213090816.A19540@pell.pell.portland.or.us>
References: <402CC114.8080100@dell633.otpefo.com> <6uvfmbktrj.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <6uvfmbktrj.fsf@zork.zork.net>; from Sean Neakums on Fri, Feb 13, 2004 at 01:12:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 01:12:48PM +0000, Sean Neakums wrote:
> Nagy Tibor <nagyt@otpbank.hu> writes:
> 
> > Hi,
> >
> > I am sorry, I have found your e-mail address in
> > ./arch/i386/kernel/setup.c. I have the problem below since a year, and
> > there is no solution yet. I guess, the problem is about e820. The
> > problem exists in 2.4.x and also in 2.6.1.
> >
> > We have two Dell Poweredge servers, an older one (PowerEdge 6300) and a
> > newer one (PowerEdge 6400). Both servers have 4GB RAM, but the Linux
> > kernel uses about 500MB less memory in the newer machine.
> 
> I may be talking through my hat, but I think that in this case you
> need to select the option for support of 64G highmem.  If I recall,
> "4G highmem" refers not to the total amount to the memory, but to the
> highest physical address that can be accessed.


   Its been several years since I did anything with the 820 code,
   but it all uses long longs so it should be fine with up to 4gb
   and a casual look at the now much hacked code doesn't seem to
   show anything that would leap out and start laughing at you.


                 ____
   david parsons \bi/ ``Sanitize the BIOS e820 map''?  
                  \/
