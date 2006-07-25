Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWGYIqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWGYIqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 04:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWGYIqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 04:46:25 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:56389 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932158AbWGYIqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 04:46:24 -0400
Date: Tue, 25 Jul 2006 10:46:21 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [Patch] [mm] More driver core fixes for -mm
Message-ID: <20060725104621.4bd0aa1a@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060725010852.75afe430.akpm@osdl.org>
References: <20060720165911.42603374@gondolin.boeblingen.de.ibm.com>
	<20060721152000.5a59813a@gondolin.boeblingen.de.ibm.com>
	<20060725010852.75afe430.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006 01:08:52 -0700,
Andrew Morton <akpm@osdl.org> wrote:

> Removing symlinks seems like a good idea.  Leaving them around might cause
> a subsequent driver load to fail due to EEXIST (assuming that the caller
> checks error codes, as if).
> 
> I assume you're referring to error paths here?

Yes, that was my reasoning.

> But I made bus_attach_device() convert the positive return value to zero. 
> See
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/hot-fixes/drivers-base-check-errors-fix.patch.

Missed that, sorry.

> 
> Is there a reason to propagate this irritating "1" back out of
> bus_attach_device() as well?

Probably not. Nobody cares whether the device was bound to a driver or
not.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
