Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSKTTEl>; Wed, 20 Nov 2002 14:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSKTTEl>; Wed, 20 Nov 2002 14:04:41 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:1478 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262425AbSKTTDZ>;
	Wed, 20 Nov 2002 14:03:25 -0500
Date: Wed, 20 Nov 2002 11:10:16 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Christoph Hellwig <hch@lst.de>, James.Bottomley@steeleye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unused includes and misleading comments from scsi_lib.c
Message-ID: <20021120111016.A20388@eng2.beaverton.ibm.com>
References: <20021117235449.B9824@lst.de> <20021120084709.A18453@eng2.beaverton.ibm.com> <20021120185048.A4886@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021120185048.A4886@lst.de>; from hch@lst.de on Wed, Nov 20, 2002 at 06:50:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 06:50:48PM +0100, Christoph Hellwig wrote:
> On Wed, Nov 20, 2002 at 08:47:09AM -0800, Patrick Mansfield wrote:
> > I had to add back the smp_lock.h include to compile with CONFIG_PREEMPT,
> > as kernel_locked was not defined and is used by in_atomic().
> 
> Bah.  Any chance you could fix the header declaring in_atomic() to pull
> in smp_lock.h by itself instead?

It is in hardirq.h, arch specific, 11 of the 20 hardirq.h files would
need the change (they reference kernel_locked) to include smp_lock.h.

665 files include smp_lock.h
89  files include hardirq.h
32  files include both

So, should I change the arch hardirq.h files to include smp_lock.h,
or just add smp_lock.h to scsi_lib.c?

-- Patrick Mansfield
