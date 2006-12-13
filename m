Return-Path: <linux-kernel-owner+w=401wt.eu-S964932AbWLMNFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWLMNFT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWLMNFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:05:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2414 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964932AbWLMNFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:05:18 -0500
Date: Wed, 13 Dec 2006 14:05:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: amitkale@netxen.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: drivers/net/netxen/netxen_nic_hw.c: stack usage problem
Message-ID: <20061213130526.GC3851@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
void netxen_nic_flash_print(struct netxen_adapter *adapter)
{
...
        struct netxen_new_user_info user_info;
...

<--  snip  -->


This allocates 2108 bytes on the stack.

That's too much considering that the complete stack might be only 4 kB.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

