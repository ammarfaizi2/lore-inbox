Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVCJEeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVCJEeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVCJEdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:33:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33244 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262556AbVCIXyO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:54:14 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: Direct io on block device has performance regression on 2.6.x kernel
Date: Wed, 9 Mar 2005 15:52:41 -0800
User-Agent: KMail/1.7.2
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       axboe@suse.de
References: <200503092218.j29MICg26503@unix-os.sc.intel.com> <m1r7iov1ya.fsf@muc.de>
In-Reply-To: <m1r7iov1ya.fsf@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503091552.41450.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 9, 2005 3:23 pm, Andi Kleen wrote:
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> writes:
> > Just to clarify here, these data need to be taken at grain of salt. A
> > high count in _spin_unlock_* functions do not automatically points to
> > lock contention.  It's one of the blind spot syndrome with timer based
> > profile on ia64.  There are some lock contentions in 2.6 kernel that
> > we are staring at.  Please do not misinterpret the number here.
>
> Why don't you use oprofileÂ>? It uses NMIs and can profile "inside"
> interrupt disabled sections.

Oh, and there are other ways of doing interrupt off profiling by using the 
PMU.  q-tools can do this I think.

Jesse
