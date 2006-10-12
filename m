Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWJLAXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWJLAXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 20:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030690AbWJLAXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 20:23:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4013 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030309AbWJLAXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 20:23:35 -0400
Date: Wed, 11 Oct 2006 17:23:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>,
       Pat Gefre <pfg@sgi.com>
Subject: Re: [PATCH 2/2] ioc4: Enable build on non-SN2
Message-Id: <20061011172332.8f7b354f.akpm@osdl.org>
In-Reply-To: <20061010120928.V71367@pkunk.americas.sgi.com>
References: <20061010120928.V71367@pkunk.americas.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 12:11:16 -0500 (CDT)
Brent Casavant <bcasavan@sgi.com> wrote:

> The SGI PCI-RT card, based on the SGI IOC4 chip, will be made available
> on Altix XE (x86_64) platforms in the near future.  As such it is now a
> misnomer for the IOC4 base device driver to live under drivers/sn, and
> would complicate builds for non-SN2.
> 
> This patch moves the IOC4 base driver code from drivers/sn to drivers/misc,
> and updates the associated Makefiles and Kconfig files to allow building
> on non-SN2 configs.  Due to the resulting change in link order, it is now
> necessary to use late_initcall() for IOC4 subdriver initialization.
> 
> ...
>
> +#include <asm/sn/addrs.h>
> +#include <asm/sn/clksupport.h>
> +#include <asm/sn/shub_mmr.h>

That doesn't work so good on x86.
