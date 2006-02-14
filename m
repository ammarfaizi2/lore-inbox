Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbWBNPAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbWBNPAE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbWBNPAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:00:01 -0500
Received: from cantor.suse.de ([195.135.220.2]:41401 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161061AbWBNPAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:00:00 -0500
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONSOLE_LP_STRICT Kconfig option
References: <43F1ED62.4050609@gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 14 Feb 2006 15:59:56 +0100
In-Reply-To: <43F1ED62.4050609@gmail.com>
Message-ID: <p731wy63s0j.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Falavigna <dktrkranz@gmail.com> writes:

> This patch, built against kernel version 2.6.16-rc3, provides a
> Kconfig option in order to easily enable or disable CONSOLE_LP_STRICT
> variable in drivers/char/lp.c without modifying it directly.

This shouldn't be a CONFIG. This should be a runtime option.
It's ridiculous to have to recompile your kernel just to fix some
problem with your printer.

e.g. sysctl, ioctl, sysfs entry, module parameter. Whatever is en
vogue these days. Easiest would be probably a module_param().

-Andi

