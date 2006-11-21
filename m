Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966404AbWKUHGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966404AbWKUHGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 02:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934223AbWKUHGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 02:06:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:37398 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S934195AbWKUHGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 02:06:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VKJdEm6/7j/N4Ix3w0qaYp0sX2IhHGsf8P8efOMP250QL1EptqGULEL6g5FnfShIYbwe8xGZMVpF7Zp8LFCFLDMRoKsWp8UQtif0qnf4BC4fCQUz8PgDULv8DkpbHHuMDUAfr8qGZsI5N0ercW++XNGJx/dYEHHiRAR2zfYk7uI=
Message-ID: <ce55079f0611202306l3cd57e48t68fe28e7e076d39a@mail.gmail.com>
Date: Tue, 21 Nov 2006 10:06:09 +0300
From: Vladimir <vovan888@gmail.com>
To: "Tony Lindgren" <tony@atomide.com>
Subject: Re: Siemens sx1: merge framebuffer support
Cc: "Pavel Machek" <pavel@ucw.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061120190404.GD4597@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061118181607.GA15275@elf.ucw.cz>
	 <20061120190404.GD4597@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/11/20, Tony Lindgren <tony@atomide.com>:
> * Pavel Machek <pavel@ucw.cz> [061118 18:16]:
> > From: Vladimir Ananiev <vovan888@gmail.com>
> >
> > Framebuffer support for Siemens SX1; this is second big patch. (Third
> > one will be mixer/sound support). Support is simple / pretty minimal,
> > but seems to work okay (and is somehow important for a cell phone :-).
>
> Pushed to linux-omap. I guess you're planning to send the missing
> Kconfig + Makefile patch for this?
>
> Also, it would be better to use omap_mcbsp_xmit_word() or
> omap_mcsbsp_spi_master_xmit_word_poll() instead of OMAP_MCBSP_WRITE as
> it does not do any checking that it worked. The aic23 and tsc2101
> audio in linux-omap tree in general has the same problem.
>
> Regards,
>
> Tony
>

Hmm. McBSP3 in SX1 is used in "GPIO mode". The only line used is CLKX,
so I think OMAP_MCBSP_WRITE would be enough. Am I wrong ?
