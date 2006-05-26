Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWEZLuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWEZLuK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWEZLuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:50:09 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:50053
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932347AbWEZLuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:50:07 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
Date: Fri, 26 May 2006 13:49:55 +0200
User-Agent: KMail/1.9.1
References: <20060526001053.D2349C7C58@atrey.karlin.mff.cuni.cz> <4476D6EC.4060501@pobox.com> <4476D95B.5030601@gmail.com>
In-Reply-To: <4476D95B.5030601@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       mb@bu3sch.de, st3@riseup.net, linville@tuxdriver.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261349.56011.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 12:33, you wrote:
> >>>> --- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> >>>> +++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> >>>> @@ -2131,6 +2131,13 @@ out:
> >>>>      return err;
> >>>>  }
> >>>>
> >>>> +#ifdef CONFIG_BCM947XX
> >>>> +static struct pci_device_id bcm43xx_ids[] = {

Call it
static struct pci_device_id bcm43xx_47xx_ids[] = {
please.

And; _important_; if you submit this change, _also_
do a patch against the devicescape version of the driver in
John Linville's wireless-dev tree
drivers/net/wireless/d80211/bcm43xx
in the tree at git://kernel.org/pub/scm/linux/kernel/git/linville/wireless-dev.git
