Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTH0PAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTH0PAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:00:40 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:48288 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263400AbTH0PAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:00:38 -0400
Subject: Re: Promise IDE patches
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jan Niehusmann <jan@gondor.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308270054.27375.bzolnier@elka.pw.edu.pl>
References: <20030826223158.GA25047@gondor.com>
	 <200308270054.27375.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061996391.22825.39.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 27 Aug 2003 15:59:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-26 at 23:54, Bartlomiej Zolnierkiewicz wrote:
> Thanks Jan.
> 
> Marcelo can you apply these patches?

The first one of these is wrong too. It'll stop some people from
being able to access existing file systems. This has to be fixed
properly (in both 2.4 and 2.6) to distinguish between 
"Can PIO LBA48" "Can DMA LBA48" and "no LBA48". The latter being
basically non existant.

If you fail to do this then existing PIO LBA48 setups will just die
on boot.

