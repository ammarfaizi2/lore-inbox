Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbVCIWvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbVCIWvz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVCIWtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:49:32 -0500
Received: from fmr21.intel.com ([143.183.121.13]:1999 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262187AbVCIWSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:18:21 -0500
Message-Id: <200503092218.j29MICg26503@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: RE: Direct io on block device has performance regression on 2.6.x kernel
Date: Wed, 9 Mar 2005 14:18:12 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUk41c0T8r0hQONT7+Vrd+cGQzRygADEiRgAAE9mMA=
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote on Wednesday, March 09, 2005 1:59 PM
> > Did you generate a kernel profile?
>
> Top 40 kernel hot functions, percentage is normalized to kernel utilization.
>
> _spin_unlock_irqrestore		23.54%
> _spin_unlock_irq			19.27%
> ....
>
> Profile with spin lock inlined, so that it is easier to see functions
> that has the lock contention, again top 40 hot functions:

Just to clarify here, these data need to be taken at grain of salt. A
high count in _spin_unlock_* functions do not automatically points to
lock contention.  It's one of the blind spot syndrome with timer based
profile on ia64.  There are some lock contentions in 2.6 kernel that
we are staring at.  Please do not misinterpret the number here.

- Ken


