Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbRFBP6k>; Sat, 2 Jun 2001 11:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262600AbRFBP6b>; Sat, 2 Jun 2001 11:58:31 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:63124 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262596AbRFBP6P>; Sat, 2 Jun 2001 11:58:15 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200106021558.f52FwCP17498@devserv.devel.redhat.com>
Subject: Re: [PATCH] es1371 race fixes
To: hch@ns.caldera.de (Christoph Hellwig)
Date: Sat, 2 Jun 2001 11:58:11 -0400 (EDT)
Cc: alan@redhat.com, t.sailer@alumni.ethz.ch, linux-kernel@vger.kernel.org
In-Reply-To: <20010602165659.A12811@caldera.de> from "Christoph Hellwig" at Jun 02, 2001 04:56:59 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   o es1371_mmap used to use lock_kernel to do some synchronistation,
>	this is superceeded by s->sem.
>   o remap_page_range (used in es1371_mmap) needs the mm semaphore as
>     stated by a comment and the code.  I have found _NO_ driver in the
>     tree so far that does this locking right...

I think they rely on the lock_kernel stuff - which Id prefer not to take out
to be honest. There is just a little too much vm related lock_kernel stuff
left to do that
