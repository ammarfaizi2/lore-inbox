Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271714AbTHMJhq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 05:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271715AbTHMJhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 05:37:46 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:57995 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S271714AbTHMJhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 05:37:46 -0400
Date: Wed, 13 Aug 2003 02:37:36 -0700
Message-Id: <200308130937.h7D9baR04722@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] read_trylock for i386
In-Reply-To: Andrew Morton's message of  Wednesday, 13 August 2003 02:01:17 -0700 <20030813020117.0acc5383.akpm@osdl.org>
X-Zippy-Says: I just had a NOSE JOB!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So it would be better if someone could sweep all those together, implement
> the necessary stubs for uniprocessor builds on all architectures and
> apologetically break the build on the remaining SMP architectures.

The uniprocessor stub is in linux/spinlock.h and already included in my patch.
All that's required is supplying _raw_read_trylock in asm/spinlock.h.
