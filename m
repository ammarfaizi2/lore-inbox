Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276702AbRJQNlt>; Wed, 17 Oct 2001 09:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276766AbRJQNlk>; Wed, 17 Oct 2001 09:41:40 -0400
Received: from sushi.toad.net ([162.33.130.105]:3998 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276682AbRJQNl0> convert rfc822-to-8bit;
	Wed, 17 Oct 2001 09:41:26 -0400
Subject: Re: [PATCH] PnP BIOS patch against 2.4.12-ac2
From: Thomas Hood <jdthood@mail.com>
To: =?ISO-8859-1?Q?J=F6rg?= Ziuber <ziuber@ict.uni-karlsruhe.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BCD2510.9633D2BD@ict.uni-karlsruhe.de>
In-Reply-To: <E15t6nz-000205-00@the-village.bc.nu>
	<1003202856.12542.57.camel@thanatos> 
	<3BCBE89C.ADD98E21@ict.uni-karlsruhe.de>
	<1003268655.12542.67.camel@thanatos> 
	<3BCD2510.9633D2BD@ict.uni-karlsruhe.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.15 (Preview Release)
Date: 17 Oct 2001 09:41:07 -0400
Message-Id: <1003326069.14282.171.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-17 at 02:28, Jörg Ziuber wrote:
> Thomas Hood wrote:
> > Is this problem related to the PnP BIOS patch?  That is,
> > do you have the same problem with a kernel that lacks the
> > patch?
> 
> Maybe it is related.
> This is at least a Sony Vaio problem, because attaching the same USB
> device to other PCs with the same (kernel)installation works without
> problems.
> It was checked to be USB-device-independent with the Vaio (same problem
> with any device).
> Because USB even works on the Vaio under Windows, the USB developers
> (uhci) told me to look in linux-kernel for the PCI/IRQ programmers due
> to a potentially broken BIOS ("IRQ routing problem")- that's where I am
> now (?).
> 
> A kernel without the patch results in the same non-recognition
> (non-USB-number-assignment) of the USB device, but when booting I get
> errors concerning a multiple reservation of IRQ9. With the patch there
> are no errors of that kind (see last mail).

That puzzles me.  I'm not sure how my patch could affect
IRQ handling.  Could you please try the version of the
patch that I submitted last night under the title
"[PATCH] PnP BIOS -- new"?  Let me know whether you do
or you do not get the error messages concerning multiple
reservations of IRQ9.

> And the "feature", that USB
> works when the shared interrupt is busy (same effect with unpatched
> kernel), makes me feel that there is a IRQ problem, specific to Sony
> Vaio. So, the PnP-BIOS-patch is my hope because it cares about Sony Vaio
> (BIOS/IRQ?) specials.

I wouldn't hope too strongly that my patch will help you.

Just to be clear.  IIUC you are saying that my patch isn't
the cause of your problem; it's just that it doesn't solve
your problem.  Is that right?

--
Thomas




