Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbVLAXKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVLAXKL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 18:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbVLAXKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 18:10:10 -0500
Received: from codepoet.org ([166.70.99.138]:23474 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S932548AbVLAXKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 18:10:09 -0500
Date: Thu, 1 Dec 2005 16:10:08 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Final 2.4.x SATA updates
Message-ID: <20051201231008.GA7921@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20051201214837.GA25256@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201214837.GA25256@havoc.gtf.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Dec 01, 2005 at 04:48:37PM -0500, Jeff Garzik wrote:
> 
> Now that ATAPI support is pretty stable, the 2.4 version of libata will
> be receiving its final updates soon.  Here is the current backport,
> for testing and feedback.

Awesome.  2.4.x lacks KM_IRQ0 in kmap_types.h

gcc -D__KERNEL__ -I/usr/src/linux-2.4.32/include -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fomit-frame-pointer -Os -falign-functions=2 -falign-jumps=2 -falign-labels=2 -falign-loops=2 -pipe -mpreferred-stack-boundary=2 -march=i486  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=libata_core  -DEXPORT_SYMTAB -c libata-core.c
libata-core.c: In function `ata_sg_clean':
libata-core.c:2427: error: `KM_IRQ0' undeclared (first use in this function)
libata-core.c:2427: error: (Each undeclared identifier is reported only once
libata-core.c:2427: error: for each function it appears in.)
libata-core.c: In function `ata_sg_setup':
libata-core.c:2701: error: `KM_IRQ0' undeclared (first use in this function)
make[2]: *** [libata-core.o] Error 1

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
