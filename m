Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbTKFRve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTKFRv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:51:28 -0500
Received: from ns.suse.de ([195.135.220.2]:47548 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263801AbTKFRvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:51:21 -0500
Date: Thu, 6 Nov 2003 18:50:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Mike Anderson <andmike@us.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Message-ID: <20031106175032.GO437@suse.de>
References: <B179AE41C1147041AA1121F44614F0B0598CE5@AVEXCH02.qlogic.org> <20031106171409.GN437@suse.de> <1068140592.5234.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068140592.5234.8.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06 2003, Arjan van de Ven wrote:
> On Thu, 2003-11-06 at 18:14, Jens Axboe wrote:
> 
> > They were there at the same time as Linux supported > 1GB IO at all. So
> > that is incorrect, it's been there all along.
> 
> .... ia64

Yeah you are right, on 64-bit platforms that could have happened. I
actually thought that CONTIGUOUS_BUFFERS took care of 4GB, but on
checking it does not.

So clustering should have been disabled then (which in the in-kernel
drive it is not). Now both 2.4 and 2.6 make that guarentee. The only
argument for disabling clustering would be for 2.4 for CPU cycle
reasons.

-- 
Jens Axboe

