Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284038AbRLAJtW>; Sat, 1 Dec 2001 04:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284037AbRLAJtN>; Sat, 1 Dec 2001 04:49:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51976 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284038AbRLAJs4>; Sat, 1 Dec 2001 04:48:56 -0500
Subject: Re: [LART] pc_keyb.c changes
To: haveblue@us.ibm.com (David C. Hansen)
Date: Sat, 1 Dec 2001 09:56:41 +0000 (GMT)
Cc: george@mvista.com (george anzinger), viro@math.psu.edu (Alexander Viro),
        linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds),
        ricklind@us.ibm.com (Rick Lindsley)
In-Reply-To: <200112010205.fB1255o22033@localhost.localdomain> from "David C. Hansen" at Nov 30, 2001 06:05:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16A6t0-0006dl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         if (rqst == PM_RESUME) {
>                 if (queue) {                    /* Aux port detected */
> -		       spin_lock_irqsave(&aux_count_lock, flags);
> +		       read_lock(&aux_count_lock);
>                	       if ( aux_count == 0) {   /* Mouse not in use */ 

Interrupts are off at this point. Its not an obvious detail without reading
the PM code, but it does cramp the style slightly 8(
