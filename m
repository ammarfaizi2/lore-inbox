Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbRAKLhf>; Thu, 11 Jan 2001 06:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbRAKLhZ>; Thu, 11 Jan 2001 06:37:25 -0500
Received: from colorfullife.com ([216.156.138.34]:21522 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131249AbRAKLhP>;
	Thu, 11 Jan 2001 06:37:15 -0500
From: Manfred <manfred@colorfullife.com>
To: Troels Walsted Hansen <troels@thule.no>
Subject: Re: [PATCH] klogd busy loop on zero byte (output from 3c59x driver)
Message-ID: <979213311.3a5d9bffdea75@localhost>
Date: Thu, 11 Jan 2001 06:41:51 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, greg@wind.enjellic.com, joey@linux.de
In-Reply-To: <CKECLHEEHJOPHGPCOCKPEECCCCAA.troels@thule.no>
In-Reply-To: <CKECLHEEHJOPHGPCOCKPEECCCCAA.troels@thule.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 134.96.7.114
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zitiere Troels Walsted Hansen <troels@thule.no>:

> Hi all.
> 
> I found a bug in the sysklogd package version 1.4. When it encounters a
> zero
> byte in the kernel logging output, the text parser enters a busy loop.

That finally explains the "klogd eats 100% cpu time" reports with ~2.2.10:

We (I and Andrea) fixed several bugs in the kernel code, but none of them
explained why klogd entered a busy loop. 


--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
