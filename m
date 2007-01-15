Return-Path: <linux-kernel-owner+w=401wt.eu-S1751802AbXAOECa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbXAOECa (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 23:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbXAOECa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 23:02:30 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:25512 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbXAOEC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 23:02:29 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=f7xTbuJCWwEROei+gg+NgpGKONhoPhAdpzGD/eym3+7cA4JtF6WZeOLwLDObQt4SeXxr+XbmSl2R+otPCREzQPhIUx+BxS4rgzGhLWg0syv8xSRjX/FvEJ25y3ylizj5b6E3OSgl5ykDoBSeofwDBIqm5tB/7k6vIzznVJYqh/0=
Message-ID: <45AAFCC6.9000700@gmail.com>
Date: Mon, 15 Jan 2007 13:02:14 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Faik Uygur <faik@pardus.org.tr>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: ahci_softreset prevents acpi_power_off
References: <fa.enjQgtLFPdSkeJjKv6eOjULTovQ@ifi.uio.no>	 <fa.kpxGqupQMKJxBBFrktFUzuoKc7c@ifi.uio.no> <45A9860D.5080506@shaw.ca>	 <200701141959.40673.faik@pardus.org.tr> <1168797978.3123.997.camel@laptopd505.fenrus.org>
In-Reply-To: <1168797978.3123.997.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> I'd be interested in finding out how to best test this; if the bios is
> really broken I'd love to add a test to the Linux-ready Firmware
> Developer Kit for this, so that BIOS developers can make sure future
> bioses do not suffer from this bug...

As reported, this is almost a butterfly effect.  ->softreset method is
only used during initialization and error recovery of ATA devices which
has almost nothing to do with the rest of the system.  This is almost
like 'changing my mixer input to line-in makes power off fail'.  (it's
more related due to ATA ACPI stuff and maybe that's why this happens but
I'm trying to make a point here.)

I'm not sure the test can be generalized and included in the firmware
devel kit.  This is a really really special obscure corner case bug
which, I believe, none will be able to recreate in the future unless the
same code is reused.  So, I think the right course of action is to bug
the manufacturer.  Eh.... Does that work with sony these days?

-- 
tejun
