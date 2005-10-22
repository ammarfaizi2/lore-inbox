Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbVJVSA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVJVSA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 14:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVJVSA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 14:00:59 -0400
Received: from [81.2.110.250] ([81.2.110.250]:39086 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751056AbVJVSA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 14:00:58 -0400
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally
	attached PHYs)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Panov <sipan@sipan.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20051022171943.GA7546@infradead.org>
References: <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com>
	 <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com>
	 <43596070.3090902@pobox.com> <43596859.3020801@adaptec.com>
	 <43596F16.7000606@pobox.com> <435A1793.1050805@s5r6.in-berlin.de>
	 <20051022105815.GB3027@infradead.org>
	 <1129994910.6286.21.camel@sipan.sipan.org>
	 <20051022171943.GA7546@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 22 Oct 2005 19:27:55 +0100
Message-Id: <1130005675.15961.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-10-22 at 18:19 +0100, Christoph Hellwig wrote:
> No.  Rewriting something from scratch is horrible engineering practice.

There I must disagree strongly. There are times when it is the right
thing to do because the original is unsalvagable (see drivers/ide). 

OTOH I do not believe the scsi layer is in this state. 


Luben, it isn't about layering. Linux does layering and does it strongly
but it does not do unneccessary layering. If the layer above is wrong
then adapt it step by step without breaking existing stuff (or making
sure the existing changes to drivers are clean and testable).

That process works. There is very little left of the original "Linux"
and most of what is left is the stuff that most needs maintenance (eg
floppy.c, tty layer). In time they too will change.

Don't go around the scsi layer for something generic, go through it.
Going around things or adding ugly hacks is fine (and justified) for a
specific single piece of hardware that is somehow brain damaged, its not
the right approach for something likely to be mainstream and generic.


