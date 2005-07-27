Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVG0Wzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVG0Wzc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVG0WtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:49:06 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:44676 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261182AbVG0Ws6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:48:58 -0400
Date: Thu, 28 Jul 2005 00:46:23 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Lars Vahlenberg <lars.vahlenberg@mandator.com>
Cc: linux-kernel@vger.kernel.org, pascal.chapperon@wanadoo.fr,
       jgarzik@pobox.com
Subject: Re: sis190 driver
Message-ID: <20050727224623.GA30308@electric-eye.fr.zoreil.com>
References: <095433EB6AB9634BB9524203BF7E303C99AA04@EXGBGMB02.europe.cellnetwork.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <095433EB6AB9634BB9524203BF7E303C99AA04@EXGBGMB02.europe.cellnetwork.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[bouncing @sis.com address removed from the Cc:]

Lars Vahlenberg <lars.vahlenberg@mandator.com> :
[...]
> I can get mii-tool to work with this patch, but if I have
> a ping command running and changing to another speed I
> stop receiving or get 1 - 3 sek pings. ei x000ms.

The current SiS driver is way more readable than the previous version
but I still have not finished to revamp its mii/phy init sequence:
- it's a bit ad hoc;
- it duplicates code here and there (see link timer and mii/phy init);
- imnsho, it tries to achieve too much work in the pci probe phase;
- it mostly ignores what is available in include/linux/mii.h and
  drivers/net/mii.c.

Expect something to test before the end of the week.

--
Ueimor
