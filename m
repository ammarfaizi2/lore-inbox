Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSLBP2P>; Mon, 2 Dec 2002 10:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSLBP2P>; Mon, 2 Dec 2002 10:28:15 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:17822 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264620AbSLBP2O>; Mon, 2 Dec 2002 10:28:14 -0500
Subject: Re: [PATCH] Unsafe MODULE_ usage in crc32.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: Matt Reppert <arashi@arashi.yi.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212021205.NAA22003@post.webmailer.de>
References: <20021130181224.4b4cddad.arashi@arashi.yi.org> 
	<200212021205.NAA22003@post.webmailer.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Dec 2002 16:08:46 +0000
Message-Id: <1038845326.1000.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 13:31, Arnd Bergmann wrote:
> I noticed another small problem with init_crc: if crc32init_be()
> fails, the memory allocated by crc32init_le() is never freed,
> see below.

The -ac tree solves that by compiling in the table. Saves on boot up
time too 8)

