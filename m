Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUBDKDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 05:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUBDKDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 05:03:05 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:53173 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S261411AbUBDKDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 05:03:02 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc3-mm1
Date: Wed, 4 Feb 2004 10:05:26 +0000
User-Agent: KMail/1.5.94
Cc: Derek Foreman <manmower@signalmarketing.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
References: <20040202235817.5c3feaf3.akpm@osdl.org> <200402032347.36489.s0348365@sms.ed.ac.uk> <Pine.LNX.4.58.0402031941560.665@uberdeity>
In-Reply-To: <Pine.LNX.4.58.0402031941560.665@uberdeity>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402041005.26649.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 February 2004 01:43, Derek Foreman wrote:
> On Tue, 3 Feb 2004, Alistair John Strachan wrote:
> > On Tuesday 03 February 2004 18:32, Bartlomiej Zolnierkiewicz wrote:
> > > On Tuesday 03 of February 2004 18:39, Alistair John Strachan wrote:
[snip]
> > > > UDMA(133) /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
> > > > hde: max request size: 128KiB
> > > >
> > > > 30 seconds later, I get something like:
> > > >
> > > > hde: lost interrupt
> > > > hde: lost interrupt
>
> Just a quick check to make sure this isn't the same ACPI problem I'm
> seeing here with an Nforce2 board and recent kernels...
>
> Does the "acpi=off" boot parameter make things work?

Thanks, this was it. I should've tried this first. Bart, the driver comes up 
just fine with acpi disabled in the most recent kernels.

ACPI is clearly broken on nForce 2, though, and booting my system with 
acpi=off, although allowing me to get to init, breaks USB initialisation. 
This breakage must have been introduced since 2.6.2-rc1-mm1.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.
