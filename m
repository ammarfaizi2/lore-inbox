Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbVIMJq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbVIMJq2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 05:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVIMJq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 05:46:28 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:7879 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932474AbVIMJq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 05:46:28 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.14-rc1 BUG: spinlock wrong owner on CPU#0 
In-reply-to: Your message of "Tue, 13 Sep 2005 11:17:59 +0200."
             <20050913091759.GA11485@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Sep 2005 19:45:10 +1000
Message-ID: <4882.1126604710@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005 11:17:59 +0200, 
Ingo Molnar <mingo@elte.hu> wrote:
>
>* Keith Owens <kaos@sgi.com> wrote:
>
>> Booting 2.6.14-rc1 on ia64, I sometimes get
>> 
>> BUG: spinlock wrong owner on CPU#0, swapper/1
>>  lock: e000003003014940, .magic: dead4ead, .owner: pdflush/75, .owner_cpu: 0
>
>hm, ia64 uses __ARCH_WANT_UNLOCKED_CTXSW and thus it releases the 
>runqueue lock early - so a certain assumption in the new, improved 
>spinlock debugging code does not apply. Does the patch below help?

Works for me, but it needs to be a -p1 patch, not -p0.

