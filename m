Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUDQIVE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 04:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbUDQIVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 04:21:04 -0400
Received: from smtp.mailix.net ([216.148.213.132]:29014 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S263714AbUDQIVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 04:21:01 -0400
Date: Sat, 17 Apr 2004 10:20:48 +0200
From: Alex Riesen <fork0@users.sourceforge.net>
To: Chris Wright <chrisw@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20040417082048.GA1269@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	Chris Wright <chrisw@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <4080060F.7030604@redhat.com> <20040416213851.GA1784@steel.home> <20040416152217.C22989@build.pdx.osdl.net> <20040416234303.GA1932@steel.home> <20040416165621.V21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20040416165621.V21045@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
X-SA-Exim-Mail-From: fork0@users.sourceforge.net
Subject: Re: POSIX message queues, libmqueue: mq_open, mq_unlink
Content-Type: text/plain; charset=us-ascii
X-Spam-Report: *  0.5 RCVD_IN_NJABL_DIALUP RBL: NJABL: dialup sender did non-local SMTP
	*      [80.140.227.8 listed in dnsbl.njabl.org]
	*  2.5 RCVD_IN_DYNABLOCK RBL: Sent directly from dynamic IP address
	*      [80.140.227.8 listed in dnsbl.sorbs.net]
	*  0.1 RCVD_IN_SORBS RBL: SORBS: sender is listed in SORBS
	*      [80.140.227.8 listed in dnsbl.sorbs.net]
	*  0.1 RCVD_IN_NJABL RBL: Received via a relay in dnsbl.njabl.org
	*      [80.140.227.8 listed in dnsbl.njabl.org]
X-SA-Exim-Version: 3.1 (built Thu Oct 23 13:26:47 PDT 2003)
X-SA-Exim-Scanned: Yes
X-uvscan-result: clean (1BEl4E-0004hi-Nb)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright, Sat, Apr 17, 2004 01:56:21 +0200:
> > > The kernel interface is simple and clean.  And in fact, requires no
> > > slashes else you'll get -EACCES.  It's not POSIX, but the library
> > > interface is.
> > > 
> > > We just discussed this yesterday:
> > > 
> > > http://marc.theaimsgroup.com/?t=108205593100003&r=1&w=2
> > 
> > now, what's is the check in the library for? BTW, it is returning the
> > other error code (EINVAL instead of EACCES), just on top of all the
> > confusion with slashes.
> 
> EINVAL in the library, sure.  EACCES is if you directly use the kernel
> interface and pass it a name with any slashes in it.  The two interfaces
> (library and kernel) aren't required to be identical.  Kernel is kept
> simplest w/ no slashes, library provides POSIX compliance.
> 

Ok. It's just that every provider of the _kernel_ interface to user
space has now to take care of being posix-compliant. Write the code for
checks, iow. That is not the case for "open", for instance.
And besides, with the patch applied the kernel is also posix compliant,
isn't it? Noone still answered why the check in library in this case.
(The patch is not applied yet, btw)

