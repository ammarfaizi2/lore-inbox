Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130918AbQLGXkP>; Thu, 7 Dec 2000 18:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130361AbQLGXjz>; Thu, 7 Dec 2000 18:39:55 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53261 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129729AbQLGXjp>; Thu, 7 Dec 2000 18:39:45 -0500
Subject: Re: bug in scsi.c
To: tigran@veritas.com (Tigran Aivazian)
Date: Thu, 7 Dec 2000 23:11:19 +0000 (GMT)
Cc: asklein@cip.physik.uni-wuerzburg.de (Andreas Klein),
        linux-kernel@vger.kernel.org, drew@colorado.edu
In-Reply-To: <Pine.LNX.4.21.0012072305060.933-100000@penguin.homenet> from "Tigran Aivazian" at Dec 07, 2000 11:07:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144ACA-00038L-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > A proper way to release the references to resources is to call daemonize()
> > > function from within the kernel thread function, which calls
> > > exit_fs()/exit_files() internally.
> > 
> > Nearly correct, the daemonize function does NOT call exit_files.
> 
> I do not post messages to linux-kernel without checking the facts
> first. Read the daemonize() function and see for yourself that you are
> wrong.

Andreas is looking at a slightly older kernel, and was right for that. Every
caller to daemonize either then did the file stuff or needed to and forgot
so I fixed daemonize

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
