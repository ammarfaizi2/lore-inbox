Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVBXL1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVBXL1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 06:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVBXL1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 06:27:08 -0500
Received: from mx1.mail.ru ([194.67.23.121]:61962 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262226AbVBXL1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 06:27:04 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM [1/8]  Base CKRM events, mods to existing kernel code
Date: Thu, 24 Feb 2005 14:27:00 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
References: <E1D4FNZ-0006vj-00@w-gerrit.beaverton.ibm.com>
In-Reply-To: <E1D4FNZ-0006vj-00@w-gerrit.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502241427.00283.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 February 2005 11:33, Gerrit Huizenga wrote:

> Core CKRM Event Callbacks.

> Not yet Addressed:

>         Use of __bitwise and sparse in enum's

You can look at include/linux/pm.h to see an example.

--- linux-2.6.11-rc5.orig/init/Kconfig
+++ linux-2.6.11-rc5/init/Kconfig

> +	  If you say Y here, enable the Resource Class File System and atleast
									^^^
Missing space.

--- /dev/null
+++ linux-2.6.11-rc5/kernel/ckrm/ckrm_events.c
> +#include <linux/config.h>

Move this to include/linux/ckrm_events.h. ckrm_events.c does not use CONFIG_*
symbols while ckrm_events.h does use CONFIG_CKRM.

	Alexey
