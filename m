Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274159AbRITC4U>; Wed, 19 Sep 2001 22:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274293AbRITC4K>; Wed, 19 Sep 2001 22:56:10 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:35845 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274159AbRITC4D>; Wed, 19 Sep 2001 22:56:03 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@ufl.edu>
To: David Lang <dlang@diginsite.com>
Cc: safemode <safemode@speakeasy.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0109191811540.7181-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.40.0109191811540.7181-100000@dlang.diginsite.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.07.08 (Preview Release)
Date: 19 Sep 2001 22:57:27 -0400
Message-Id: <1000954648.4340.91.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-09-19 at 21:13, David Lang wrote:
> also how useful is the latency info once swapping starts? if you have
> something that gets swapped out it will have horrible latency and skew the
> results (or at the very least you won't know if the problem is disk IO or
> fixable problems)

Its not that bad because the patch measures latency across points where
preemption was enabled and disabled -- the various kernel locking
mechanisms.

Thus either page fault holds a lock and it is a legimate latency
recorded over that specific lock, or it doesn't in which case its not an
issue.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

