Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWA0XdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWA0XdA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWA0Xck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:32:40 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:20996 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422687AbWA0Xci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:32:38 -0500
Date: Sat, 28 Jan 2006 00:32:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [x86-64] align per-cpu section to configured cache bytes
Message-ID: <20060127233227.GA9274@mars.ravnborg.org>
References: <20060127220242.13917.839.sendpatchset@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127220242.13917.839.sendpatchset@tetsuo.zabbo.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 02:02:42PM -0800, Zach Brown wrote:
> -  . = ALIGN(32);
> +  . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);

Grepping other arch's than just x86 and x86_64 it looks like a common
thing.
Is this fix really only relevant for x86 + x86_64 or should it be done
for all arch's?

If we do it for all archs we may as well create:
#define PERCPU(aling) ...
macro in asm-generic/vmlinux.lds.h

	Sam
