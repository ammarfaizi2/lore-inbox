Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291012AbSBGA6b>; Wed, 6 Feb 2002 19:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291019AbSBGA6W>; Wed, 6 Feb 2002 19:58:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63759 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291013AbSBGA6E>; Wed, 6 Feb 2002 19:58:04 -0500
Subject: Re: The IBM order relaxation patch
To: Ulrich.Weigand@de.ibm.com (Ulrich Weigand)
Date: Thu, 7 Feb 2002 00:18:47 +0000 (GMT)
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <OF5FF19417.595BC760-ONC1256B58.00762715@de.ibm.com> from "Ulrich Weigand" at Feb 06, 2002 10:50:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YcH1-0006ua-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >with a GPF flag? What they describe does not happen in an
> >interrupt context, so we can sleep.
> 
> Because nobody even *tries* to free adjacent pages to build up
> a free order-2 area.  You could wait really long ...

Without the rmap patch you can't easily do it

> rmap method could help here, because with reverse mappings we
> can at least try to free adjacent areas (because we then at least
> *know* who's using the pages).

rmap definitely makes it a real no brainer to do this at least for small
clusters of pages. Doing large chunks gets progressively harder
