Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132114AbRAJWmB>; Wed, 10 Jan 2001 17:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135949AbRAJWlt>; Wed, 10 Jan 2001 17:41:49 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:13834 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132114AbRAJWli>; Wed, 10 Jan 2001 17:41:38 -0500
Date: Wed, 10 Jan 2001 17:41:06 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Keith Owens <kaos@ocs.com.au>, Nathan Walp <faceprint@faceprint.com>,
        Hans Grobler <grobh@sun.ac.za>, <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.4.0-ac5
In-Reply-To: <E14GTro-00019E-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0101101737240.30973-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Jan 2001, Alan Cox wrote:

> > it.  I could never persuade Ingo to use wrmsr_eio() and check the
> > return code, maybe this will change his mind.  Extract from kdb v1.7.
>
> I have a patch from Ingo to fix this one properly. Its just getting tested

i prefer clear oopses and bug reports instead of ignoring them. A failed
MSR write is not something to be taken easily. MSR writes if fail mean
that there is a serious kernel bug - we want to stop the kernel and
complain ASAP. And correct code will be much more readable that way.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
