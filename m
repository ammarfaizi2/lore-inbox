Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315098AbSDWGux>; Tue, 23 Apr 2002 02:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315099AbSDWGux>; Tue, 23 Apr 2002 02:50:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60424 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315098AbSDWGuw>; Tue, 23 Apr 2002 02:50:52 -0400
Subject: Re: Why HZ on i386 is 100 ?
To: george@mvista.com (george anzinger)
Date: Tue, 23 Apr 2002 08:08:31 +0100 (BST)
Cc: jalvo@mbay.net (John Alvord), pavel@suse.cz (Pavel Machek),
        davidm@hpl.hp.com, davidel@xmailserver.org (Davide Libenzi),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3CC4861C.F21859A6@mvista.com> from "george anzinger" at Apr 22, 2002 02:52:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16zuPf-0007yD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is in accounting (or time slicing if you prefer) where we
> need to start a timer each time a task is context switched to, and stop
> it when the task is switched away.  The overhead is purely in the set up
> and tear down.  MOST of these never expire.

Done properly on many platforms a variable tick is very very easy and also
very efficient to handle. X86 is a paticular problem case because the timer
is so expensive to fiddle with
