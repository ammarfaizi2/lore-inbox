Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272003AbTG2TER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272006AbTG2TEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:04:16 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:4781 "EHLO fed1mtao08.cox.net")
	by vger.kernel.org with ESMTP id S272003AbTG2TEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:04:13 -0400
Date: Tue, 29 Jul 2003 12:04:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Miles Lane <miles.lane@comcast.net>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 (Linus tree ppc32 build) -- drivers/built-in.o(.init.text+0x5e64): In function `init_control': undefined reference to `nvram_read_byte'
Message-ID: <20030729190411.GJ16051@ip68-0-152-218.tc.ph.cox.net>
References: <200307271801.44966.miles.lane@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307271801.44966.miles.lane@comcast.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 06:01:44PM -0700, Miles Lane wrote:

>   LD      .tmp_vmlinux1
> drivers/built-in.o(.init.text+0x5e64): In function `init_control':
> : undefined reference to `nvram_read_byte'
> drivers/built-in.o(.init.text+0x5e64): In function `init_control':
> : relocation truncated to fit: R_PPC_REL24 nvram_read_byte
> drivers/built-in.o(.init.text+0x5ef0): In function `init_control':
> : undefined reference to `nvram_read_byte'
> drivers/built-in.o(.init.text+0x5ef0): In function `init_control':
> : relocation truncated to fit: R_PPC_REL24 nvram_read_byte
> drivers/built-in.o(.init.text+0x67cc): In function `init_platinum':
> : undefined reference to `nvram_read_byte'
> drivers/built-in.o(.init.text+0x67cc): In function `init_platinum':
> : relocation truncated to fit: R_PPC_REL24 nvram_read_byte
> drivers/built-in.o(.init.text+0x67ec): In function `init_platinum':
> : undefined reference to `nvram_read_byte'
> drivers/built-in.o(.init.text+0x67ec): In function `init_platinum':
> : relocation truncated to fit: R_PPC_REL24 nvram_read_byte
> drivers/built-in.o(.init.text+0x7c08): In function `init_imstt':
> : undefined reference to `nvram_read_byte'
> drivers/built-in.o(.init.text+0x7c08): In function `init_imstt':
> : relocation truncated to fit: R_PPC_REL24 nvram_read_byte
> drivers/built-in.o(.init.text+0x7c24): more undefined references to 
> `nvram_read_byte' follow
> drivers/built-in.o(.init.text+0x7c24): In function `init_imstt':
> : relocation truncated to fit: R_PPC_REL24 nvram_read_byte

The problem is that arch/ppc/platforms/pmac_nvram.c needs to be compiled
on CONFIG_PPC_PMAC, not on CONFIG_NVRAM (so edit
arch/ppc/platforms/Makefile).

-- 
Tom Rini
http://gate.crashing.org/~trini/
