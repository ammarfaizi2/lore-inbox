Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286784AbRLVONv>; Sat, 22 Dec 2001 09:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286786AbRLVONm>; Sat, 22 Dec 2001 09:13:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19722 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286784AbRLVONW>; Sat, 22 Dec 2001 09:13:22 -0500
Subject: Re: [RFC] Scheduler queue implementation ...
To: pavel@suse.cz (Pavel Machek)
Date: Sat, 22 Dec 2001 14:23:36 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20011221202113.D415@elf.ucw.cz> from "Pavel Machek" at Dec 21, 2001 08:21:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Hn3p-0004IC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But ... UI performance should not matter much. And that is *abuse* of
> threads.

A UI thread often makes sense and its a real latency/efficiency trade off
given the inconvenient human. Thats why I was playing at scheduling all
running processes for an mm on one CPU - your comments make me think that
"for non hogs" might have some relevance.

> If I have a raytracer, and want to explore 8 cpus, how do I do that?
> Separate scene into 8 pieces, make sure no r/w data are shared, and
> clone(CLONE_VM). Are there other ways? [I do not know if people are
> really doing it like that. *I* would do it that way. Is it bad?]

Thats probably the best SMP way
