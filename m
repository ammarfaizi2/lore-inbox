Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130473AbQLJUez>; Sun, 10 Dec 2000 15:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbQLJUep>; Sun, 10 Dec 2000 15:34:45 -0500
Received: from zero.tech9.net ([209.61.188.187]:20740 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S130473AbQLJUel>;
	Sun, 10 Dec 2000 15:34:41 -0500
Date: Sun, 10 Dec 2000 15:04:14 -0500 (EST)
From: "Robert M. Love" <rml@tech9.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Compile Failure: mga_dma.o on 2.4.0-test12-pre8
In-Reply-To: <Pine.LNX.4.30.0012101445010.15992-100000@phantasy.awol.org>
Message-ID: <Pine.LNX.4.30.0012101501160.17790-100000@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, the problem is that drm_device.tq is a tq_struct, which we just got
done redoing. tq->next was removed in favor of the new tq.list.

so drm_device.tq needs to be rewritten to use the new task queue, and the
problem will be solved.

ill dig through the archives and see if i can figure out the new queue (is
there something in /Documentation?) and get a patch out ... i wonder how
many other drivers need to be patched to handle the new task queue?

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
