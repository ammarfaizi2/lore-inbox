Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVB1DYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVB1DYK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 22:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVB1DYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 22:24:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38109 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261541AbVB1DX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 22:23:57 -0500
Date: Mon, 28 Feb 2005 03:23:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [ patch 7/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050228032356.GC5300@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
References: <42225A74.3040404@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42225A74.3040404@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +config SERIAL_JSM
> +        tristate "Digi International NEO PCI Support"
> +        select SERIAL_CORE

shouldn't this depend on CONFIG_PCI?

> diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/Makefile linux-2.6.9.new/drivers/serial/jsm/Makefile
> --- linux-2.6.9.orig/drivers/serial/jsm/Makefile	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9.new/drivers/serial/jsm/Makefile	2005-02-27 17:01:43.725941288 -0600
> @@ -0,0 +1,36 @@
> +##################################################################
> +# Copyright 2003 Digi International (www.digi.com)
> +# Scott H Kilau <Scott_Kilau at digi dot com>
> +# 
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2, or (at your option)
> +# any later version.
> +# 
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
> +# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
> +# PURPOSE.  See the GNU General Public License for more details.
> +# 
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> +# 
> +# 
> +#       NOTE TO LINUX KERNEL HACKERS:  DO NOT REFORMAT THIS CODE!
> +# 
> +#       Send any bug fixes/changes to:  Eng.Linux at digi dot com.
> +#       Thank you.
> +# 
> +# 
> +##################################################################
> +
> +#
> +# Makefile for Jasmine adapter
> +#
> +
> +obj-$(CONFIG_SERIAL_JSM) += jsm.o
> +
> +jsm-objs :=    jsm_driver.o jsm_mgmt.o jsm_neo.o\
> +               jsm_proc.o jsm_tty.o
> +

I doubt anyone can register a copyright on a trivial three-line makefile.
Also please use jsm-y instead of jsm-objs.

