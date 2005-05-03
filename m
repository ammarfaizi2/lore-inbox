Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVECPEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVECPEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 11:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVECPEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 11:04:42 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:5131
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261578AbVECPEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 11:04:41 -0400
Date: Tue, 3 May 2005 08:04:40 -0700
From: Phil Oester <kernel@linuxace.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       trini@kernel.crashing.org
Subject: Re: Garbage on serial console after serial driver loads
Message-ID: <20050503150440.GA9621@linuxace.com>
References: <20050328173652.GA31354@linuxace.com> <20050328200243.C2222@flint.arm.linux.org.uk> <1115129833.4446.23.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115129833.4446.23.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 03:17:12PM +0100, David Woodhouse wrote:
> Not really; it's just a quick hack applied without any real
> consideration of the problem. If we're messing up the baud rate when we
> change the master clock, then just make it change the divisor
> accordingly at the same time. We don't seem to store the active
> parameters of the serial console anywhere useful; we can do it just by
> reading back the divisor and multiplying by eight though...

FYI, just tested this patch, and it does solve the garbage problem for me.

Thanks,
Phil
