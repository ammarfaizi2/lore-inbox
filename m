Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270384AbTHSOJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270319AbTHSOJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:09:54 -0400
Received: from zeus.kernel.org ([204.152.189.113]:11771 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S270625AbTHSNd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 09:33:26 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
From: Jes Sorensen <jes@wildopensource.com>
Date: 19 Aug 2003 09:20:34 -0400
In-Reply-To: <1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <m3d6f1ss0t.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> On Maw, 2003-08-19 at 10:03, Jes Sorensen wrote:
>> That would be totally messy. Having drivers do the accounting of
>> what mask is currently set and have them switch back and forth
>> depending on what type of allocation is currently being used would
>> be a nightmare to debug.

Alan> It is messy, but the consistent mask only helps a small subset
Alan> of cases.  Having an __pci_alloc_foo that took the mask as an
Alan> argument is (a) trivial (b) adds almost no code (c) solves the
Alan> general case problem.

And d) puts the accounting back into the drivers in duplicate. So far
we have managed pretty well with the distinction between consistent
and dynamic, but sure if there is hardware out there where it makes
sense to have a more generic interface we should consider it.

Jes

