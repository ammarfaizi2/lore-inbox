Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVCIX03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVCIX03 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbVCIXY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:24:59 -0500
Received: from one.firstfloor.org ([213.235.205.2]:43175 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262259AbVCIXXK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:23:10 -0500
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: Re: Direct io on block device has performance regression on 2.6.x
 kernel
References: <200503092218.j29MICg26503@unix-os.sc.intel.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 10 Mar 2005 00:23:09 +0100
In-Reply-To: <200503092218.j29MICg26503@unix-os.sc.intel.com> (Kenneth W.
 Chen's message of "Wed, 9 Mar 2005 14:18:12 -0800")
Message-ID: <m1r7iov1ya.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> writes:
>
> Just to clarify here, these data need to be taken at grain of salt. A
> high count in _spin_unlock_* functions do not automatically points to
> lock contention.  It's one of the blind spot syndrome with timer based
> profile on ia64.  There are some lock contentions in 2.6 kernel that
> we are staring at.  Please do not misinterpret the number here.

Why don't you use oprofileÂ>? It uses NMIs and can profile "inside" 
interrupt disabled sections.

-Andi
