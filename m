Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310858AbSCHNHZ>; Fri, 8 Mar 2002 08:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310854AbSCHNHP>; Fri, 8 Mar 2002 08:07:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18443 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310850AbSCHNHH>; Fri, 8 Mar 2002 08:07:07 -0500
Subject: Re: [PATCH] preempt-kernel on 2.4.19-pre2-ac2 bugfix
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Fri, 8 Mar 2002 13:21:39 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rml@tech9.net (Robert Love),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020308022751.GF28141@matchmail.com> from "Mike Fedyk" at Mar 07, 2002 06:27:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jKJX-00069s-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Won't this show up in rss or some other ps mem listing -or- is this
> something that hasn't been exported to user space before on linux?

It might show up in /proc/<pid>/* - the maps list will show address
spaces. Otherwise address space leaks have always been invisible and its
only when you leak to 3Gb of unused address space the app will notice if
its never touching it
