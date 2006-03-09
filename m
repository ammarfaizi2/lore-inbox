Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWCIKFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWCIKFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 05:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWCIKFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 05:05:42 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:57751 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750845AbWCIKFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 05:05:41 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
	<17423.32792.500628.226831@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0603081716400.32577@g5.osdl.org>
	<200603082034.00238.jbarnes@virtuousgeek.org>
	<17423.45681.476222.143773@cargo.ozlabs.ibm.com>
From: Jes Sorensen <jes@sgi.com>
Date: 09 Mar 2006 05:05:39 -0500
In-Reply-To: <17423.45681.476222.143773@cargo.ozlabs.ibm.com>
Message-ID: <yq0mzg02arw.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Paul" == Paul Mackerras <paulus@samba.org> writes:

Paul> Jesse Barnes writes:
>> So ultimately mmiowb() is the only thing drivers really have to
>> care about on Altix (assuming they do DMA mapping correctly), and
>> the rules for that are fairly simple.  Then they can additionally
>> use read_relaxed() to optimize performance a bit (quite a bit on
>> big systems).

Paul> If I can be sure that all the drivers we care about on PPC use
Paul> mmiowb correctly, I can reduce or eliminate the barrier in
Paul> write*, which would be nice.

Paul> Which drivers have been audited to make sure they use mmiowb
Paul> correctly?  In particular, has the USB driver been audited?

I think the primary drivers we've looked at are drivers/net/tg3.c,
drivers/net/s2io.c, drivers/scsi/qla1280.c, and possibly the
qla[234]xxx series - thats probably it!

While we have USB on the systems, I don't think anyone has spend a lot
of time verifying it in this context. At least the keyboard and mouse
I have on this box seems to behave.

Cheers,
Jes
