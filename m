Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVBZEfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVBZEfm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 23:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVBZEfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 23:35:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63367 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261158AbVBZEfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 23:35:37 -0500
Message-ID: <421FFC86.7090802@pobox.com>
Date: Fri, 25 Feb 2005 23:35:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Felix <gregfelixlkml@gmail.com>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: PROBLEM: ICH7 SATA drive not detected.
References: <e16ac85e050225153649939bed@mail.gmail.com>	 <421FBC0B.5070004@pobox.com> <e16ac85e05022517024beb5b38@mail.gmail.com>
In-Reply-To: <e16ac85e05022517024beb5b38@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comment out the function call to piix_disable_ahci() and see what happens.

         if (port_info[0]->host_flags & PIIX_FLAG_AHCI) {
                 int rc = piix_disable_ahci(pdev);
                 if (rc)
                         return rc;
         }

Regards,

	Jeff


