Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319551AbSILQpq>; Thu, 12 Sep 2002 12:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319555AbSILQpp>; Thu, 12 Sep 2002 12:45:45 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:33526
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319551AbSILQpp> convert rfc822-to-8bit; Thu, 12 Sep 2002 12:45:45 -0400
Subject: Re: sched.h changes in 2.4.19rc5aa1 / Digi's cpci driver doesn't
	compile
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pasi =?ISO-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209121923320.17322-100000@edu.joroinen.fi>
References: <Pine.LNX.4.44.0209121923320.17322-100000@edu.joroinen.fi>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 12 Sep 2002 17:50:53 +0100
Message-Id: <1031849453.2902.98.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 17:30, Pasi Kärkkäinen wrote 
> The code goes like this (cpci.c line 3847):
> 
> 	current->state = TASK_INTERRUPTIBLE;
> 	current->counter = 0;   /* make us low-priority */
> 
> current is task_struct.

Its assuming old old scheduler bits. I suspect just removing the
current->counter junk will make it happy

