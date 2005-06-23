Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbVFWWvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVFWWvd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVFWWvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 18:51:33 -0400
Received: from mid-2.inet.it ([213.92.5.19]:57579 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S262769AbVFWWv3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 18:51:29 -0400
From: Valerio Vanni <valerio.vanni@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel: __alloc_pages: 0-order allocation failed
Date: Fri, 24 Jun 2005 00:51:27 +0200
Message-ID: <61dmb1t6onlec2rd9tk9femhke6f3s8ehg@4ax.com>
References: <4ieIc-67r-1@gated-at.bofh.it> <4ihmM-8ny-5@gated-at.bofh.it>
In-Reply-To: <4ihmM-8ny-5@gated-at.bofh.it>
X-Mailer: Forte Agent 1.93/32.576 Italiano
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005 19:40:08 +0200, Chris Wedgwood <cw@f00f.org>
wrote:
>> as before) or the kernel is in some way locked up (in particular: is
>> it necessary/better to reboot? Is there some risk of filesystem
>> corruption?).
>
>It's memory allocation failures.  This might not work until memory is
>free but it shouldn't kill the kernel of be a huge problem if it's
>just the result of one ore more processes being memory hungry

I'm blaming myself for not having given a closer look before shutting
down the machine.
But, as I said, the shut down happened regularly. Later, to be sure, i
ran an fsck on all partitions and they were ok.

>It could also occur if there is a memory leak, in which case there is
>a bug that needs to be fixed and a reboot would be needed (I would
>only suspect that if it did it often and processes were not using much
>memory though).

It was the first time: this machine had been running on the same
kernel for six month with very long uptimes interrupted only by ups
control daemon (during blackouts).

Ah, no: the kernel had been changed about one month ago, but it was
the same version (2.4.26) and the same .config (except ext3 support
which I moved from modules to kernel itself).


-- 
Ci sono 10 tipi di persone al mondo: quelle che capiscono il sistema binario
e quelle che non lo capiscono.
