Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVCHUtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVCHUtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVCHUpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:45:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:49302 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262113AbVCHUlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 15:41:22 -0500
Date: Tue, 8 Mar 2005 12:34:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: torvalds@osdl.org, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org, jt@hpl.hp.com
Subject: Re: PCMCIA product id strings -> hashes generation at compilation
 time? [Was: Re: [patch 14/38] pcmcia: id_table for wavelan_cs]
Message-Id: <20050308123426.249fa934.akpm@osdl.org>
In-Reply-To: <20050308191138.GA16169@isilmar.linta.de>
References: <20050227161308.GO7351@dominikbrodowski.de>
	<20050307225355.GB30371@bougret.hpl.hp.com>
	<20050307230102.GA29779@isilmar.linta.de>
	<20050307150957.0456dd75.akpm@osdl.org>
	<20050307232339.GA30057@isilmar.linta.de>
	<20050308191138.GA16169@isilmar.linta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski <linux@dominikbrodowski.net> wrote:
>
> Most pcmcia devices are matched to drivers using "product ID strings"
>  embedded in the devices' Card Information Structures, as "manufactor ID /
>  card ID" matches are much less reliable. Unfortunately, these strings cannot
>  be passed to userspace for easy userspace-based loading of appropriate
>  modules (MODNAME -- hotplug), so my suggestion is to also store crc32 hashes
>  of the strings in the MODULE_DEVICE_TABLEs, e.g.:
> 
>  PCMCIA_DEVICE_PROD_ID12("LINKSYS", "E-CARD", 0xf7cb0b07, 0x6701da11),

What is the difficulty in passing these strings via /sbin/hotplug arguments?

> ...
>  To make the life easier for device driver authors,
>  	- a big warning is put into dmesg if a pcmcia driver is inserted
>  	  into the kernel and the hash mentioned in PCMCIA_DEVICE_PROD_ID()
>  	  is incorrect,

As long as the kernel shouts loudly at the driver developer at
development-time, and that shouting mentions a bit of documentation in
Documentation/somewhere, I expect we'll be OK.

