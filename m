Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263992AbUDPXrD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263974AbUDPXoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:44:08 -0400
Received: from smtp.mailix.net ([216.148.213.132]:41665 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S263895AbUDPXnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:43:12 -0400
Date: Sat, 17 Apr 2004 01:43:03 +0200
From: Alex Riesen <fork0@users.sourceforge.net>
To: Chris Wright <chrisw@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20040416234303.GA1932@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	Chris Wright <chrisw@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <4080060F.7030604@redhat.com> <20040416213851.GA1784@steel.home> <20040416152217.C22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20040416152217.C22989@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
X-SA-Exim-Mail-From: fork0@users.sourceforge.net
Subject: Re: POSIX message queues, libmqueue: mq_open, mq_unlink
Content-Type: text/plain; charset=us-ascii
X-Spam-Report: *  0.5 RCVD_IN_NJABL_DIALUP RBL: NJABL: dialup sender did non-local SMTP
	*      [80.140.244.238 listed in dnsbl.njabl.org]
	*  2.5 RCVD_IN_DYNABLOCK RBL: Sent directly from dynamic IP address
	*      [80.140.244.238 listed in dnsbl.sorbs.net]
	*  0.1 RCVD_IN_SORBS RBL: SORBS: sender is listed in SORBS
	*      [80.140.244.238 listed in dnsbl.sorbs.net]
	*  0.1 RCVD_IN_NJABL RBL: Received via a relay in dnsbl.njabl.org
	*      [80.140.244.238 listed in dnsbl.njabl.org]
X-SA-Exim-Version: 3.1 (built Thu Oct 23 13:26:47 PDT 2003)
X-SA-Exim-Scanned: Yes
X-uvscan-result: clean (1BEczB-0002ez-GC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright, Sat, Apr 17, 2004 00:22:17 +0200:
> > My concern is that the tests are rather pointing that something in
> > kernel is not implemented correctly. _The_ checks in particular.
> > Because if they _are_ implemented correctly, you don't need to patch the
> > functionality in the user space.
> >
> > And if the kernel code does check the incoming arguments correctly,
> > what is the point to check them again? Just to make the point, that
> > passing in not an absolute path is not portable?
> 
> The kernel interface is simple and clean.  And in fact, requires no
> slashes else you'll get -EACCES.  It's not POSIX, but the library
> interface is.
> 
> We just discussed this yesterday:
> 
> http://marc.theaimsgroup.com/?t=108205593100003&r=1&w=2

now, what's is the check in the library for? BTW, it is returning the
other error code (EINVAL instead of EACCES), just on top of all the
confusion with slashes.

