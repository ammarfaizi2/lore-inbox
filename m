Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWIPQhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWIPQhn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 12:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWIPQhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 12:37:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39403 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964825AbWIPQhm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 12:37:42 -0400
Subject: Re: [PATCH] gt96100: move to pci_get_device API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, source@mvista.com
In-Reply-To: <450BF28D.7010807@gmail.com>
References: <1158330426.29932.53.camel@localhost.localdomain>
	 <450BF28D.7010807@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 16 Sep 2006 18:01:03 +0100
Message-Id: <1158426063.6069.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-16 am 14:47 +0159, ysgrifennodd Jiri Slaby:
> They wanted pci_device_table with for_each_pci_dev+pci_match_id here...

Thats a seperate problem space for this and a lot of other drivers. We
need to get rid of pci_find_* more urgently than we need to make drivers
support hotplug of their own hardware.

The former causes oopses walking the PCI bus tree the latter is just a
limitation of drivers

