Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUEFUbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUEFUbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 16:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUEFUbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 16:31:10 -0400
Received: from fmr04.intel.com ([143.183.121.6]:18126 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262972AbUEFUbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 16:31:05 -0400
Message-Id: <200405062030.i46KUuF13625@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <axboe@suse.de>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Cache queue_congestion_on/off_threshold
Date: Thu, 6 May 2004 13:30:57 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQzNWWEguCe5OWsQOiX2ronQ1me2AAaAq4Q
In-Reply-To: <20040506064301.GC10069@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Jens Axboe wrote on Wed, May 05, 2004 11:43 PM
> On Wed, May 05 2004, Andrew Morton wrote:
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > Do you have any numbers at all for this? I'd say these calculations are
> > >  severly into the noise area when submitting io.
> >
> > The difference will not be measurable, but I think the patch makes sense
> > regardless of what the numbers say.
>
> Humm dunno, I'd rather save the sizeof(int) * 2.

Strictly speaking from memory consumption point of view, it probably comes
for free since sizeof(struct request_queue) currently is 456 bytes on x86
and 816 on 64bit arch.  The structure is being rounded to 512 or 1024 with
kmalloc.  If it is on the borderline to next kmalloc size, it probably should
be revisited.  But so far it has been noise on the positive side.

- Ken


