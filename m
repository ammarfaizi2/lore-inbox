Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293669AbSCFQgk>; Wed, 6 Mar 2002 11:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293668AbSCFQga>; Wed, 6 Mar 2002 11:36:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2578 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293664AbSCFQgW>; Wed, 6 Mar 2002 11:36:22 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 6 Mar 2002 16:50:15 +0000 (GMT)
Cc: jdike@karaya.com (Jeff Dike), hpa@zytor.com (H. Peter Anvin),
        bcrl@redhat.com (Benjamin LaHaise),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <505.1015411792@redhat.com> from "David Woodhouse" at Mar 06, 2002 10:49:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iecJ-0007Nn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You say 'at once'. Does UML somehow give pages back to the host when they're 
> freed, so the pages that are no longer used by UML can be discarded by the 
> host instead of getting swapped?

Doesn't seem to but it looks like madvise might be enough to make that
happen. That BTW is an issue for more than UML - it has a bearing on
running lots of Linux instances on any supervisor/virtualising system
like S/390
