Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268956AbRHBOZk>; Thu, 2 Aug 2001 10:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268955AbRHBOZa>; Thu, 2 Aug 2001 10:25:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46097 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268956AbRHBOZR>; Thu, 2 Aug 2001 10:25:17 -0400
Subject: Re: setsockopt(..,SO_RCVBUF,..) sets wrong value
To: mbartz@optushome.com.au (Manfred Bartz)
Date: Thu, 2 Aug 2001 15:26:59 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Manfred Bartz" at Aug 02, 2001 08:34:47 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SJRD-0000fn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I do a setsockopt(..,SO_RCVBUF,..) and then read the value back
> with getsockopt(), the reported value is exactly twice of what I set.
> Running the same code on Solaris and on DEC UNIX reports back the
> exact size I set.
> Looking at the code it seems that the  *2  should not be there:

You are making assumptions not guaranteed in POSIX or SuS. In the Linux case
we deliberately allow more than requested as our memory accounting behaviour
for buffers is very different to BSD

