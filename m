Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266012AbTGCAgH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 20:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbTGCAgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 20:36:07 -0400
Received: from mail.inw.de ([217.6.75.131]:60037 "EHLO mail.internetwork-ag.de")
	by vger.kernel.org with ESMTP id S266012AbTGCAgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 20:36:03 -0400
Message-ID: <3F037DF5.BCF5DF22@inw.de>
Date: Wed, 02 Jul 2003 17:51:01 -0700
From: Till Immanuel Patzschke <tip@inw.de>
Organization: interNetwork AG
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Faye Pearson <faye@zippysoft.com>
CC: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: Re: pppd pppoatm multilink?
References: <20030702121820.GA21592@clara.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm,

how is that supposed to work?  The trick about PPPoA is that the underlying
(logical) structure provides a distinct physical link (like in the modem
world).  The actual ATM cells have no tag that allows the BRAS to sort out which
PPP connection is currently sending packets, so you actually have to have more
than one VC to make this work.

Cheers,

Immanuel

Faye Pearson wrote:

> My ISP is about to trial multilink ADSL for use with routers like the
> Cisco 1600, but I was wondering if it could be done 'on the cheap' (well
> relatively anyway) with a linux box and a couple of PCI ADSL modems.
>
> AIUI it should work the same as MP using two ttyS devices but
> first glance suggests this won't work, the pppoatm module for pppd
> seems to take the VPI.VCI as the device and there doesn't seem to
> be any way to say which physical ATM device to use.  The VPI.VCI
> would be the same at both interfaces.  Does it just pick the
> first available ATM device?  Or just the first ATM device?
>
> Thanks
>
> Faye.
>
> Please also cc: me in on replies, thank you.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

