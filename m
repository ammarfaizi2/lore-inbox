Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbVJTNqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVJTNqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 09:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVJTNqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 09:46:36 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:56449 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751361AbVJTNqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 09:46:35 -0400
Subject: Re: [PATCH] libata: fix broken Kconfig setup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, davej@redhat.com
In-Reply-To: <200510171006.39206.jbarnes@virtuousgeek.org>
References: <20051017044606.GA1266@havoc.gtf.org>
	 <200510170952.34174.jbarnes@virtuousgeek.org> <4353D96F.90805@pobox.com>
	 <200510171006.39206.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Oct 2005 15:14:44 +0100
Message-Id: <1129817684.15200.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So sometimes the legacy IDE driver will lock up when it tries to drive 
> both ports in a combined configuration?  In that case, can't we just 
> disable the legacy IDE driver for these chips and force the use of the 
> libata version?

Now that libata is beginning to behave well I'd vote for that option,
however in kernel libata lacks several essential items for PATA feature
parity (HPA, ATAPI, suspend/resume, correct tuning). It's getting there
and I've got some more stuff waiting for Jeff, but it isn't there yet

