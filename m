Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTKGXCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbTKGWYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:24:21 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:48657 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263985AbTKGJhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:37:38 -0500
Date: Fri, 7 Nov 2003 09:37:37 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Message-ID: <20031107093737.B1992@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B0598CE6@AVEXCH02.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B179AE41C1147041AA1121F44614F0B0598CE6@AVEXCH02.qlogic.org>; from andrew.vasquez@qlogic.com on Thu, Nov 06, 2003 at 09:45:50AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 09:45:50AM -0800, Andrew Vasquez wrote:
> No.  We've had this IOWR problem since the inception of 5.x series
> driver.  Software (SMS 3.0) has been built on top of the this IOCTL
> interface.  We painfully discovered this problem when we began to look
> at other non-x86 platforms (ppc64).

I don't know what SMS is, but Linux provides a stable ABI for stable
kernel series and only those.  We already have anough garbage from mistakes
in older kernel releases that we won't accept more with new driver
submission.  If SMS didn't use a abstraction library it would have a problem,
yes.

> >  Also having different ioctl values for different plattforms is not
> >  an option for Linux.
> > 
> 
> The better (right) fix would be to push this interface change onto the
> caller of the IOCTLs where they can manage the differences there, and
> the driver could once and for all shed itself of this nagging problem.
> That is the consensus here.  The _BAD conversion was only done so the
> driver would compile.

Sorry, I don't parse that.  There's no reason different architectures
should have differences in the ioctl calling convention, so there shouldn't
be anything to deal with in the caller either.

