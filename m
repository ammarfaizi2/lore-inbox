Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278083AbRJLUGd>; Fri, 12 Oct 2001 16:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278106AbRJLUGY>; Fri, 12 Oct 2001 16:06:24 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1040 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278083AbRJLUGP>; Fri, 12 Oct 2001 16:06:15 -0400
Subject: Re: kapm-idled Funny in 2.4.10-ac12
To: jdthood@mail.com (Thomas Hood)
Date: Fri, 12 Oct 2001 21:12:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1002915626.10291.67.camel@thanatos> from "Thomas Hood" at Oct 12, 2001 03:40:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15s8fW-0000PV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> get_cmos_time is in time.c .  It does a bunch of CMOS_READs
> without taking rtc_lock.
> 
> Methinks that the
>     save_flags(flags); ...; cli(); ...; restore_flags(flags);
> constructs in apm.c need some attention.

Well spotted. Yes the CMOS handling does still seem a bit random in places
