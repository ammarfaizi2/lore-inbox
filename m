Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130024AbRAJWgr>; Wed, 10 Jan 2001 17:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132178AbRAJWgg>; Wed, 10 Jan 2001 17:36:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36358 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130024AbRAJWgW>; Wed, 10 Jan 2001 17:36:22 -0500
Subject: Re: Oops in 2.4.0-ac5
To: kaos@ocs.com.au (Keith Owens)
Date: Wed, 10 Jan 2001 22:37:13 +0000 (GMT)
Cc: faceprint@faceprint.com (Nathan Walp), grobh@sun.ac.za (Hans Grobler),
        linux-kernel@vger.kernel.org, mingo@redhat.com (Ingo Molnar)
In-Reply-To: <3360.979165747@ocs3.ocs-net> from "Keith Owens" at Jan 11, 2001 09:29:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GTro-00019E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is why my original NMI for UP code in kdb uses wrmsr_eio() instead
> of wrmsr.  wrmsr_eio() catches errors where the APIC does not support
> the msr and returns EIO instead of oopsing and taking the kernel with
> it.  I could never persuade Ingo to use wrmsr_eio() and check the
> return code, maybe this will change his mind.  Extract from kdb v1.7.

I have a patch from Ingo to fix this one properly. Its just getting tested
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
