Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288109AbSAHPim>; Tue, 8 Jan 2002 10:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288111AbSAHPic>; Tue, 8 Jan 2002 10:38:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36882 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288109AbSAHPiU>; Tue, 8 Jan 2002 10:38:20 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Tue, 8 Jan 2002 15:46:20 +0000 (GMT)
Cc: Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-15?q?N=FCtzel?=),
        andrea@suse.de (Andrea Arcangeli),
        riel@conectiva.com.br (Rik van Riel),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        akpm@zip.com.au (Andrew Morton), rml@tech9.net (Robert Love)
In-Reply-To: <Pine.LNX.4.21.0201081153160.19178-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Jan 08, 2002 11:59:36 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NySC-0006pc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Andrew Morten`s read-latency.patch is a clear winner for me, too.
> 
> AFAIK Andrew's code simply adds schedule points around the kernel, righ=
> t?=20
> 
> If so, nope, I do not plan to integrate it.

Yep. It has the most wonderful effect on system latency without actually
breaking any semantics. Pre-empt is a trickier one because it does change
actual behaviour a lot more, although it should be preserving locking
rules.

Alan
