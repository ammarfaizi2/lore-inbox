Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293709AbSCFUkn>; Wed, 6 Mar 2002 15:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293729AbSCFUkd>; Wed, 6 Mar 2002 15:40:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11782 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293709AbSCFUk0>; Wed, 6 Mar 2002 15:40:26 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: jdike@karaya.com (Jeff Dike)
Date: Wed, 6 Mar 2002 20:54:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dwmw2@infradead.org (David Woodhouse),
        hpa@zytor.com (H. Peter Anvin), bcrl@redhat.com (Benjamin LaHaise),
        linux-kernel@vger.kernel.org
In-Reply-To: <200203062025.PAA03727@ccure.karaya.com> from "Jeff Dike" at Mar 06, 2002 03:25:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iiQQ-00087K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, MADV_DONTNEED looks right.  UML and Linux/s390 (assuming VM has the
> equivalent of MADV_DONTNEED) would need a hook in free_pages to make that
> happen.

VM allows you to give it back a page and if you use it again you get a
clean copy. What it seems to lack is the more ideal "here have this page
and if I reuse it trap if you did throw it out" semantic.

> > That BTW is an issue for more than UML - it has a bearing on running
> > lots of Linux instances on any supervisor/virtualising system like S/390
> 
> On a side note, the "unused memory is wasted memory" behavior that UML and 
> Linux/s390 inherit is also less than optimal for the host.

Yes. I believe IBM folks are studying that
