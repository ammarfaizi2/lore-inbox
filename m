Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280126AbRLGNJW>; Fri, 7 Dec 2001 08:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280114AbRLGNIN>; Fri, 7 Dec 2001 08:08:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63497 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280126AbRLGNIH>; Fri, 7 Dec 2001 08:08:07 -0500
Subject: Re: 2GB process crashing on 2.4.14
To: Paul.Sargent@3dlabs.com (Paul Sargent)
Date: Fri, 7 Dec 2001 13:16:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011207125821.D31161@3dlabs.com> from "Paul Sargent" at Dec 07, 2001 12:58:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CKrx-0005nL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to work out why the process doesn't start using swap. Swap
> appears to be working, as all other processes have been swapped out. Is it
> possible for a running process to be partially swapped out? Could it be that
> the process is asking for memory which can't be swapped?

Most probably the process is running out of address space to allocate from.
There is 3Gb of available space. Of that some is your stack, some your
binary, some your libraries.  Getting above 3Gb/process on x86 is very hairy
with a bad performance hit

Alan
