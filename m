Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbTFXIHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 04:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264403AbTFXIHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 04:07:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60882
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264453AbTFXIGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 04:06:24 -0400
Subject: Re: [PATCH] proper allocation of hwif->io_ports resources
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <200306232345.43959.bzolnier@elka.pw.edu.pl>
References: <200306232345.43959.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056442701.14611.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Jun 2003 09:18:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-23 at 22:45, Bartlomiej Zolnierkiewicz wrote:
> Patch gets rid of check_region/check_mem_region from ide-probe.c.
> I will push to Linus if there are no objections..

Its a vague step in the right direction. The resource registration 
has to be done by the caller in the end, fortunately for most cases
that means the pci setup code.

By the time ide.c sees stuff its too late because we've already been
banging on the chip.

