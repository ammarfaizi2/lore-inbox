Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbWAXRnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbWAXRnt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 12:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbWAXRnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 12:43:49 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:46522 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030493AbWAXRns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 12:43:48 -0500
Date: Tue, 24 Jan 2006 18:44:44 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       7eggert@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43D63BD8.nailCPI11XBZ8@burner>
Message-ID: <Pine.LNX.4.58.0601241831410.2181@be1.lrz>
References: <5y7B5-1dw-15@gated-at.bofh.it> <5y7KL-1DZ-31@gated-at.bofh.it>
 <5yddh-1pA-47@gated-at.bofh.it> <5ydni-1Qq-3@gated-at.bofh.it>
 <5yek1-3iP-53@gated-at.bofh.it> <5yeth-3us-33@gated-at.bofh.it>
 <5yf5O-4iF-19@gated-at.bofh.it> <5yfI4-5kU-11@gated-at.bofh.it>
 <5ygE4-6LK-35@gated-at.bofh.it> <5yhqg-7ZR-5@gated-at.bofh.it>
 <5yi2X-zm-7@gated-at.bofh.it> <E1F1KG8-0000v7-3Q@be1.lrz> <43D63BD8.nailCPI11XBZ8@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2006, Joerg Schilling wrote:
> Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org> wrote:
> > Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > [...]
> > > On Solaris, you (currently) use a profile enabled shell (pfsh, pfksh or pfcsh)
> > > that calls getexecuser() in order to find whether there is a specific
> > > treatment needed. If this specific treatment is needed, then the shell calls
> > > execve(/usr/bin/pfexec cmd <args>)
> > > else it calls  execve(cmd <args>)
> > > 
> > > I did recently voted to require all shells to be profile enabled by default.
> >
> > Why? I asume there will only be few programs requiring to be run by a
> > wrapper, and mv /usr/bin/foo to /usr/pfexec-bin/foo;
> > echo $'#!/bin/sh\n/usr/sbin/pfexec /usr/pfexec-bin/foo "$@"' > /usr/bin/foo;
> > chmod 755 /usr/bin/foo
> > should be easier than patching e.g. all callers of cdrecord, and it won't
> > slow down starting non-profiled applications.
> 
> Because the architecture review commitee decided this would be the right way.
> 
> Note that we are on a migration from the classical root/non-root UNIX to a fine 
> grained privileges handling. The current documentation says that you need to 
> have a profile enabled shell as your SHELL in order to be able to use a 
> root-less Solaris.

If the shell was the only program calling cdrecord, this would work out as 
expected.
-- 
My mail reader can beat up your mail reader. 
