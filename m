Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbUDPVmD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263838AbUDPVja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:39:30 -0400
Received: from smtp.mailix.net ([216.148.213.132]:7039 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S263811AbUDPVjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:39:03 -0400
Date: Fri, 16 Apr 2004 23:38:51 +0200
From: Alex Riesen <fork0@users.sourceforge.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20040416213851.GA1784@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	Ulrich Drepper <drepper@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4080060F.7030604@redhat.com>
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
X-uvscan-result: clean (1BEb31-0005p0-3r)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Looking over the code in libmqueue-4.31, I noticed the checks for the
> > name validity in the mq_open and mq_unlink. Why are they needed?  They
> > are pointless if the code in kernel depends on the valid name,
>
> You are contradicting yourself.
>
> Anyway, non-absolute path names passed to the functions mean the
> behavior is unspecified.  No portable application must ever do this.  It
> is enforced for this reason plus if there comes a time when we want to
> do something special which doesn't conflict with standard-compliant
> behavior we have a possibility for that.  Unlike wh6at you think, the
> tests *are* useful.

My concern is that the tests are rather pointing that something in
kernel is not implemented correctly. _The_ checks in particular.
Because if they _are_ implemented correctly, you don't need to patch the
functionality in the user space.

And if the kernel code does check the incoming arguments correctly,
what is the point to check them again? Just to make the point, that
passing in not an absolute path is not portable?


