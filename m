Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135700AbRDSUlt>; Thu, 19 Apr 2001 16:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135704AbRDSUlh>; Thu, 19 Apr 2001 16:41:37 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:29070 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S135696AbRDSUlI>;
	Thu, 19 Apr 2001 16:41:08 -0400
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.LNX.4.31.0104191036220.5052-100000@penguin.transmeta.com>
	<m3ofts3d4k.fsf@otr.mynet.cygnus.com>
	<20010419222228.J682@nightmaster.csn.tu-chemnitz.de>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 19 Apr 2001 13:40:19 -0700
In-Reply-To: Ingo Oeser's message of "Thu, 19 Apr 2001 22:22:28 +0200"
Message-ID: <m31yqo1v4c.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de> writes:

> Are you sure, you can implement SMP-safe, atomic operations (which you need
> for all up()/down() in user space) WITHOUT using privileged
> instructions on ALL archs Linux supports?

Which processors have no such instructions but are SMP-capable?

> How do we do this on nccNUMA machines later? How on clusters[1]?

Clusters are not my problem.  They require additional software.  And
NUMA machines maybe be requiring a certain sequence in which the
operations must be performed and the hardware should take care of the
rest.


I don't really care what the final implementation will be like.  For
UP and SMP machines I definitely want to have as much as possible at
user-level.  If you need a special libpthread for NUMA machines, so be
it.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
