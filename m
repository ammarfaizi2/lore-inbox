Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTLMGS5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 01:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTLMGS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 01:18:57 -0500
Received: from [64.65.189.210] ([64.65.189.210]:35235 "EHLO
	mail.pacrimopen.com") by vger.kernel.org with ESMTP id S264459AbTLMGS4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 01:18:56 -0500
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: root@chaos.analogic.com
Cc: John Bradford <john@grabjohn.com>,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0312121435570.1356@chaos>
References: <16345.51504.583427.499297@l.a> <yw1xd6auyvac.fsf@kth.se>
	 <Pine.LNX.4.53.0312121000150.10423@chaos>
	 <200312121928.hBCJSLBs000384@81-2-122-30.bradfords.org.uk>
	 <Pine.LNX.4.53.0312121435570.1356@chaos>
Content-Type: text/plain
Message-Id: <1071296320.16407.17.camel@menion.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Dec 2003 22:18:41 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, and I recall we agreed to disagree where the FDC stop must
> be put, but we both agreed that it must be stopped. I still contend
> that since the Linux startup code takes control away from the BIOS,
> it's that codes responsibility to turn OFF things that the BIOS
> might have left ON.
> 
> Funny thing. It's so trivial, anybody/everybody could turn the
> floppy motor off, but all the fingers point to somebody else's
> code.
> 
> It's a bug in Linux, not in a boot-loader. That bug was covered up
> until the FDC code got modularized. Once we were able to compile
> a kernel without the FDC, the bug was exposed. So, I suggest that
> we just fix the bug and be done with it. It's not a performance
> problem, the write to the port occurs exactly once during the nest
> 999 days of up-time. It's just an attempt to make a mountain out
> of a mole-hill.


We have had (do have?) several cases of optional "this workaround", or
"that workaround" as per-hardware config options.  If this is that
objectionable for genral consumption then someone ought to submit a
patch to do the dirty deed but put it in as a configurable workaround
(CONFIG_TURNFLOPPYOFF=Y/N), and leave it at that. [For maximum
perversity, it could also be a MODULE.] This does not affect everyone
right?  I have never tried booting w/o the floppy module, so I really
don't know about my system.   


js

