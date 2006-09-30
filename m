Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWI3Kdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWI3Kdr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 06:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWI3Kdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 06:33:47 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:38884 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750766AbWI3Kdp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 06:33:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 4/6]: powerpc/cell spidernet ethtool -i version number info.
Date: Sat, 30 Sep 2006 12:33:45 +0200
User-Agent: KMail/1.9.1
Cc: jeff@garzik.org, akpm@osdl.org, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
References: <20060929230552.GG6433@austin.ibm.com> <20060929232139.GL6433@austin.ibm.com>
In-Reply-To: <20060929232139.GL6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609301233.45871.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Saturday 30 September 2006 01:21 schrieb Linas Vepstas:
> This patch adds version information as reported by
> ethtool -i to the Spidernet driver.
>
> From: James K Lewis <jklewis@us.ibm.com>
> Signed-off-by: James K Lewis <jklewis@us.ibm.com>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Same comment as last time this was submitted:

> @@ -2303,6 +2304,8 @@ static struct pci_driver spider_net_driv
>   */
>  static int __init spider_net_init(void)
>  {
> +       printk("spidernet Version %s.\n",VERSION);
> +
>         if (rx_descriptors < SPIDER_NET_RX_DESCRIPTORS_MIN) {
>                 rx_descriptors = SPIDER_NET_RX_DESCRIPTORS_MIN;
>                 pr_info("adjusting rx descriptors to %i.\n",

This is missing a printk level and a space character. More importantly,
you should not print the presence of the driver to the syslog, but
the presence of a device driven by it.

	Arnd <><
