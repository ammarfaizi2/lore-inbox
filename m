Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277392AbRJEOex>; Fri, 5 Oct 2001 10:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277394AbRJEOep>; Fri, 5 Oct 2001 10:34:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3334 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277392AbRJEOed>; Fri, 5 Oct 2001 10:34:33 -0400
Subject: Re: ioremap() vs. ioremap_nocache()
To: jes@sunsite.dk (Jes Sorensen)
Date: Fri, 5 Oct 2001 15:39:51 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davidm@hpl.hp.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <d3itdutbtq.fsf@lxplus014.cern.ch> from "Jes Sorensen" at Oct 05, 2001 04:12:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pW8l-0006Yd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan> On x86 ioremap will give mappings appropriate to the object you
> Alan> map - which means by default it wil give uncached mappings. The
> Alan> PCI hardware will do intelligent things in certain cases such as
> Alan> write merging
> 
> Are you thereby saying that ioremap() and ioremap_nocache() are
> identical on the x86?

In certain peculiar cases - no. Think about an ioremap of an object mapped
onto the system bus as RAM.
