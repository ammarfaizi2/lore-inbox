Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267024AbUBGSyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 13:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267025AbUBGSyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 13:54:09 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:6667 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267024AbUBGSyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 13:54:07 -0500
Subject: Re: Unknown symbol _exit when compiling VMware vmmon.o module
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <yw1xad3u7oaw.fsf@kth.se>
References: <1076175615.798.9.camel@teapot.felipe-alfaro.com>
	 <yw1xad3u7oaw.fsf@kth.se>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1076180005.798.16.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sat, 07 Feb 2004 19:53:25 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-07 at 19:11, Måns Rullgård wrote:
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> writes:
> 
> > Hi!
> >
> > After installing VMware Workstation 4.5.0-7174 and running
> > vmware-config.pl, I get the following error when trying to insert
> > vmmon.ko into the kernel:
> >
> > vmmon: Unknown symbol _exit
> 
> I've seen it too.  I just removed that call from the source and
> rebuilt.  It's not supposed to ever get there anyway.  I still don't
> understand what it was doing there in the first place.  Oddly, it
> compiled with kernel 2.6.2, but not with some later updates.

Yeah! I experienced the same with -mm kernels... It seems the changes
that motivated that have been integrated in mainline now. For now, I've
removed any reference to _exit from the module sources.

