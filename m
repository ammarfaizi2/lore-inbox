Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVKUUEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVKUUEp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVKUUEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:04:45 -0500
Received: from www.swissdisk.com ([216.144.233.50]:35732 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S1750945AbVKUUEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:04:45 -0500
Date: Mon, 21 Nov 2005 10:56:09 -0800
From: Ben Collins <bcollins@debian.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Adrian Bunk <bunk@stusta.de>, Dave Jones <davej@redhat.com>,
       dan@dennedy.org, linux1394-devel@lists.sourceforge.net,
       scjody@steamballoon.com, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/raw1394.c: fix a NULL pointer dereference
Message-ID: <20051121185609.GB14962@swissdisk.com>
References: <20051120232009.GH16060@stusta.de> <20051120234055.GF28918@redhat.com> <20051120235242.GR16060@stusta.de> <43821C47.6010702@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43821C47.6010702@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >-		CSR1212_FREE(cache);
> > 		ret = -EFAULT;
> > 	} else {
> > 		cache->len = req->req.length;
> 
> This looks OK to me. But there seems to be another bug. I think the line
> 
> 	kfree(cache);
> 
> after the if and else blocks has to be replaced by
> 
> 	CSR1212_FREE(cache);

Yes, please. We are trying to keep the csr1212.[ch] files compatible for
use in userspace and kernel.

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/
