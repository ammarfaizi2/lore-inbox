Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUJFBM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUJFBM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUJFBM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:12:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266603AbUJFBMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:12:13 -0400
Message-ID: <4163465F.6070309@pobox.com>
Date: Tue, 05 Oct 2004 21:11:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com>
In-Reply-To: <52is9or78f.fsf_-_@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Jeff> I strongly recommend disabling kernel preemption.  It is a
>     Jeff> hack that hides bugs.
> 
> Why do you say that?  Preempt seems to be the cleanest way to low
> latency, and if anything it exposes locking bugs and races rather than
> hiding anything.

Clean?  Hardly.  It breaks up code paths that were never written to be 
broken up.  The proper fix is to locate and fix high latency code paths. 
  Preempt does nothing but hide those high latency code paths, and 
discourage people from seeking a better solution.

Fix the drivers, rather than bandaid over them with preempt.

If all code paths in the kernel were low latency, then you would not 
need preempt at all.

	Jeff



