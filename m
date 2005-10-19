Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVJSPmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVJSPmZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVJSPmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:42:25 -0400
Received: from bno-84-242-95-19.nat.karneval.cz ([84.242.95.19]:31201 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751115AbVJSPmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:42:24 -0400
Message-ID: <4356695B.9050107@gmail.com>
Date: Wed, 19 Oct 2005 17:42:19 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Roland Dreier <rolandd@cisco.com>
CC: Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: What is struct pci_driver.owner for?
References: <52sluymu26.fsf@cisco.com> <435560D0.8050205@pobox.com>	<20051018205908.GA32435@suse.de> <52oe5mmt65.fsf@cisco.com>
In-Reply-To: <52oe5mmt65.fsf@cisco.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier napsal(a):

>    Greg> But what it really does today is create the symlink from the
>    Greg> driver to the module that is contained in it, in sysfs.
>    Greg> Which is very invaluable for people who want to know these
>    Greg> things (installer programs, etc.)
>
>    Greg> That "module" symlink is created only if the .owner field is
>    Greg> set.  That's why people are going through and adding it to
>    Greg> all of the drivers in the system.
>
>OK, I'll make my own small contribution and push this for 2.6.15:
>  
>
Ok, but read Documentation/SubmittingPatches. At least Signed-off-by is
missing.

>diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
>--- a/drivers/infiniband/hw/mthca/mthca_main.c
>+++ b/drivers/infiniband/hw/mthca/mthca_main.c
>@@ -1196,6 +1196,7 @@ MODULE_DEVICE_TABLE(pci, mthca_pci_table
> 
> static struct pci_driver mthca_driver = {
> 	.name		= DRV_NAME,
>+	.owner		= THIS_MODULE,
> 	.id_table	= mthca_pci_table,
> 	.probe		= mthca_init_one,
> 	.remove		= __devexit_p(mthca_remove_one)
>  
>
regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E

