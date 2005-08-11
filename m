Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbVHKNmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbVHKNmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 09:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbVHKNmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 09:42:08 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:61374 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030303AbVHKNmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 09:42:07 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: Need help in understanding  x86  syscall
To: Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Thu, 11 Aug 2005 15:41:57 +0200
References: <4Ae73-6Mm-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1E3DJm-0000jy-0B@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ukil a <ukil_a@yahoo.com> wrote:

> Now I had the doubt that if the the syscall
> implementation is very large will the scheduling and
> other interrupts be blocked for the whole time till
> the process returns from the ISR (because in an ISR by
> default the interrupts are disabled unless “sti” is
> called explicitly)?

According to my documentation it isn't. A software interrupt is a far call
with an extra pushf, and a hardware interrupt is protected against recursion
by the PIC, not by an interrupt flag.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
