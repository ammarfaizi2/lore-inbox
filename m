Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291679AbSBHSCZ>; Fri, 8 Feb 2002 13:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291689AbSBHSCE>; Fri, 8 Feb 2002 13:02:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28689 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291690AbSBHSB5>; Fri, 8 Feb 2002 13:01:57 -0500
Subject: Re: [patch] larger kernel stack (8k->16k) per task
To: tigran@veritas.com (Tigran Aivazian)
Date: Fri, 8 Feb 2002 18:15:15 +0000 (GMT)
Cc: arjanv@redhat.com (Arjan van de Ven), linux-kernel@vger.kernel.org,
        riel@conectiva.com.br (Rik van Riel),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33.0202081645170.1359-100000@einstein.homenet> from "Tigran Aivazian" at Feb 08, 2002 04:59:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZFYK-0004SV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> to reproduce it with larger stack and then (with aid of /proc/stack) the
> offender is found and fixed. I cc'd Alan; if he thinks this is a bad idea
> I would be interested to know why.

Personal feeling: it would be better to vmalloc the stack in this case
and use the existing vmalloc red zones. For 2.5 that should work out ok
unlike 2.4 where the scsi and usb will break
