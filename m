Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288289AbSAHUb4>; Tue, 8 Jan 2002 15:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288290AbSAHUbq>; Tue, 8 Jan 2002 15:31:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20742 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288289AbSAHUbc>; Tue, 8 Jan 2002 15:31:32 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: akpm@zip.com.au (Andrew Morton)
Date: Tue, 8 Jan 2002 20:13:49 +0000 (GMT)
Cc: phillips@bonn-fries.net (Daniel Phillips),
        anton@samba.org (Anton Blanchard), andrea@suse.de (Andrea Arcangeli),
        kernel@Expansa.sns.it (Luigi Genoni),
        Dieter.Nuetzel@hamburg.de (Dieter N?tzel),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        riel@conectiva.com.br (Rik van Riel),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        rml@tech9.net (Robert Love)
In-Reply-To: <3C3B4CB7.FEAAF5FC@zip.com.au> from "Andrew Morton" at Jan 08, 2002 11:47:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16O2d3-0007VF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> low-latency kernel".  Now, IF we can come to this decision, then
> internal preemption is the way to do it.  But it affects ALL kernel

The pre-empt patches just make things much much harder to debug. They
remove some of the predictability and the normal call chain following
goes out of the window because you end up seeing crashes in a thread with
no idea what ran the microsecond before

Some of that happens now but this makes it vastly worse.

The low latency patches don't change the basic predictability and
debuggability but allow you to hit a 1mS pre-empt target for the general
case.

Alan
