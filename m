Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276988AbRKHRxf>; Thu, 8 Nov 2001 12:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277068AbRKHRx0>; Thu, 8 Nov 2001 12:53:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44559 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276988AbRKHRxW>; Thu, 8 Nov 2001 12:53:22 -0500
Subject: Re: [PATCH] mmap + wrapping around to 0
To: linux@xdr.com (Dave Ashley (linux mailing list))
Date: Thu, 8 Nov 2001 18:00:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111081656.fA8Guht24668@xdr.com> from "Dave Ashley (linux mailing list)" at Nov 08, 2001 08:56:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161tTi-00009l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in the inline function do_mmap(), change
>         if ((offset + PAGE_ALIGN(len)) < offset)
> to
>         if ((offset + PAGE_ALIGN(len)-1) < offset)

Shouldnt that be

	PAGE_ALIGN(len-1)

so you compute the page of the last byte ?
