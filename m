Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265986AbUFUEzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUFUEzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 00:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUFUEzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 00:55:12 -0400
Received: from host61.200-117-131.telecom.net.ar ([200.117.131.61]:53725 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S265986AbUFUEzI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 00:55:08 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-bk way too fast
Date: Mon, 21 Jun 2004 02:00:42 -0300
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
References: <40D64DF7.5040601@pobox.com> <40D657B7.8040807@pobox.com> <20040620210233.1e126ddc.akpm@osdl.org>
In-Reply-To: <20040620210233.1e126ddc.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406210200.42594.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > Looks like disabling CONFIG_ACPI fixes things.  Narrowing down cset
> > now...
>
> Try this.
>
>
>  		for (idx = 0; idx < mp_irq_entries; idx++)
>  			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
> -				(mp_irqs[idx].mpc_dstapic == ioapic) &&
> +				(mp_irqs[idx].mpc_dstapic ==
> +					mp_ioapics[ioapic].mpc_apicid) &&

Still goes too fast :-( (tried on 2.6.7-mm1)

Regards,
Norberto

