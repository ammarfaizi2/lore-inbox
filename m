Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284037AbRLGK24>; Fri, 7 Dec 2001 05:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285455AbRLGK2q>; Fri, 7 Dec 2001 05:28:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:521 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284037AbRLGK2b>; Fri, 7 Dec 2001 05:28:31 -0500
Subject: Re: Linux/Pro  -- clusters
To: dalecki@evision.ag
Date: Fri, 7 Dec 2001 10:37:15 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3C109668.E5818E11@evision-ventures.com> from "Martin Dalecki" at Dec 07, 2001 11:14:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CINX-0005MC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For those of us who want to run a standards based operating system can
> > you do the 32bit dev_t. Otherwise some slightly fundamental things don't
> > work. You know boring stuff like ls, find, df, and other standard unix
> > commands. Those export a dev_t cookie.
> 
> I don't think this is what Linus was talking about. The current problem

Linus wasnt talking about what I was talking about. Problem the other way
around 8)

> For example please grep for the MINOR() macro in the scsi layer...
> Most of the places where it's used should be replaced by a simple
> driver instance enumerator. I did this once already, so this is for
> sure.

it become block_device->instance or ->minor

major/minors for old stuff still end up leaking into user space and
mattering there. I'm not sure the best option for that
