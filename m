Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbUCRKsW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 05:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUCRKsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 05:48:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48050 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262513AbUCRKsV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:48:21 -0500
Message-ID: <40597E68.7090908@pobox.com>
Date: Thu, 18 Mar 2004 05:48:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: tulip (pnic) errors in 2.6.5-rc1
References: <16473.28514.341276.209224@alkaid.it.uu.se>	<40597123.8020903@pobox.com>	<405971B3.3080700@pobox.com> <16473.32039.160055.63522@alkaid.it.uu.se>
In-Reply-To: <16473.32039.160055.63522@alkaid.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> Jeff Garzik writes:
>  > er, oops... lemme find the right patch...
> 
> No change, still a flood of those tulip_rx() interrupt messages.

hmmm.  Well, it is something unrelated to tulip driver, then.

Did you recently change module options, or forget to disable tulip_debug 
in modprobe.conf or modules.conf ?

         if (tulip_debug > 4)
                 printk(KERN_DEBUG "%s: exiting interrupt, csr5=%#4.4x.\n",
                            dev->name, inl(ioaddr + CSR5));

Those messages only appear if a non-default verbosity has been selected.

	Jeff



