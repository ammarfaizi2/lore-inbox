Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281789AbRKQR6H>; Sat, 17 Nov 2001 12:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281792AbRKQR5r>; Sat, 17 Nov 2001 12:57:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22287 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281793AbRKQR5g>; Sat, 17 Nov 2001 12:57:36 -0500
Subject: Re: [PATCH][RFC] Re: 2.4.15-pre5: /proc/cpuinfo broken
To: viro@math.psu.edu (Alexander Viro)
Date: Sat, 17 Nov 2001 18:04:41 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), wwcopt@optonline.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0111171250310.11475-100000@weyl.math.psu.edu> from "Alexander Viro" at Nov 17, 2001 12:51:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1659pZ-0007sI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	c) hunt down and fix the userland that relies on arithmetics
> on file position in case of regular files (POSIX prohibits it, SuS allows).

You forgot d.

(d) - when someone seeks in the file do the seek, and document that they
lose their guarantees. So they fall back to existing 1.0->2.4 behaviour.
You just run the iterator either on or back from scratch to the seek point.

Alan
