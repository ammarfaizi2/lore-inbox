Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTLLTYo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTLLTYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:24:44 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3712 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261863AbTLLTXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:23:23 -0500
Date: Fri, 12 Dec 2003 19:28:21 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312121928.hBCJSLBs000384@81-2-122-30.bradfords.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0312121000150.10423@chaos>
References: <16345.51504.583427.499297@l.a>
 <yw1xd6auyvac.fsf@kth.se>
 <Pine.LNX.4.53.0312121000150.10423@chaos>
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from "Richard B. Johnson" <root@chaos.analogic.com>:
> On Fri, 12 Dec 2003, [iso-8859-1] M=E5ns Rullg=E5rd wrote:
> 
> > Dale Mellor <dale@dmellor.dabsol.co.uk> writes:
> >
> > > 1. Floppy motor spins when floppy module not installed.
> >
> > It's a known problem.  Some broken BIOSes don't turn off the motor
> > after probing for a disk.  One solution is to change the boot priorit=
> y
> > in the BIOS settings so the hard disk is tried before floppy.  If you
> > ever need to boot from a floppy, you can change it back.
> >
> > --
> > M=E5ns Rullg=E5rd
> > mru@kth.se
> 
> It is not a broken BIOS! The BIOS timer that ticks 18.206 times
> per second has an ISR that, in addition to keeping time, turns
> OFF the FDC motor after two seconds of inactivity. This ISR is taken
> away by Linux. Therefore Linux must turn off that motor! It is a
> Linux bug, not a BIOS bug. Linux took control away from the BIOS
> during boot.

We discussed almost exactly the same problem at length on LKML just
two months ago:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106545766213063&w=2

John.
