Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVFGWrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVFGWrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVFGWpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:45:32 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:14733 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S262029AbVFGWpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:45:14 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: Bizarre oops after suspend to RAM (was: Re: [ACPI] Resume from Suspend to RAM)
To: Stefan =?ISO-8859-1?Q?D=F6singer?= <stefandoesinger@gmx.at>,
       acpi-devel@lists.sourceforge.net, Matthew Garrett <mjg59@srcf.ucam.org>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 07 Jun 2005 03:06:08 +0200
References: <4cnEB-7Y5-13@gated-at.bofh.it> <4cnEB-7Y5-19@gated-at.bofh.it> <4cnEB-7Y5-11@gated-at.bofh.it> <4cpZW-1yL-13@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DfSXh-0006lI-39@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Dösinger <stefandoesinger@gmx.at> wrote:

> So it does reach the kernel, right? I don't know if I remembered that call
> correctly, but "lcall $0xffff,$0" should call the real mode BIOS reset
> code...
> Anyone else who can correct me here?

If it's realmode, it should do a jump to the boot entry point of the BIOS.
This does not imply a reset, some machines will just hang. Especially after
messing with the interrupts or mapping some RAM over the lower half of the
BIOS, where the boot code is expected.

Good (== long gone) old times with DOS.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
