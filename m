Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932747AbWANHat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbWANHat (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 02:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWANHat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 02:30:49 -0500
Received: from xenotime.net ([66.160.160.81]:48587 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751274AbWANHas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 02:30:48 -0500
Date: Fri, 13 Jan 2006 23:30:44 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Message-Id: <20060113233044.248bcd1d.rdunlap@xenotime.net>
In-Reply-To: <20060114072810.GA7866@mars.ravnborg.org>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
	<20060114072810.GA7866@mars.ravnborg.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2006 08:28:10 +0100 Sam Ravnborg wrote:

> Hi Randy
>  
> > --- linux-2615-g9.orig/drivers/scsi/Makefile
> > +++ linux-2615-g9/drivers/scsi/Makefile
> > @@ -164,6 +164,9 @@ CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-
> >  zalon7xx-objs	:= zalon.o ncr53c8xx.o
> >  NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
> >  libata-objs	:= libata-core.o libata-scsi.o
> > +ifeq ($(CONFIG_SCSI_SATA_ACPI),y)
> > +  libata-objs	+= libata-acpi.o
> > +endif
> 
> How about:
> libata-y	:= libata-core.o libata-scsi.o
> libata-$(CONFIG_SCSI_SATA_ACPI) += libata-acpi.o

Hi Sam,
OK, I'll change that.

Thanks.
---
~Randy
