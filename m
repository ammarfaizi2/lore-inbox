Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932745AbWANH2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbWANH2v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 02:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWANH2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 02:28:51 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:39181 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751233AbWANH2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 02:28:50 -0500
Date: Sat, 14 Jan 2006 08:28:10 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Message-ID: <20060114072810.GA7866@mars.ravnborg.org>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113224252.38d8890f.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy
 
> --- linux-2615-g9.orig/drivers/scsi/Makefile
> +++ linux-2615-g9/drivers/scsi/Makefile
> @@ -164,6 +164,9 @@ CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-
>  zalon7xx-objs	:= zalon.o ncr53c8xx.o
>  NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
>  libata-objs	:= libata-core.o libata-scsi.o
> +ifeq ($(CONFIG_SCSI_SATA_ACPI),y)
> +  libata-objs	+= libata-acpi.o
> +endif

How about:
libata-y	:= libata-core.o libata-scsi.o
libata-$(CONFIG_SCSI_SATA_ACPI) += libata-acpi.o

	Sam

