Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWEGSjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWEGSjP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 14:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWEGSjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 14:39:15 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:40689 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751213AbWEGSjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 14:39:14 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: [patch 0/6] New Generic HW RNG (#2)
Date: Sun, 7 May 2006 20:39:07 +0200
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Sergey Vlasov <vsu@altlinux.ru>
References: <20060507143806.465264000@pc1>
In-Reply-To: <20060507143806.465264000@pc1>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605072039.08702.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 May 2006 16:38, Michael Buesch wrote:
> Second try. Various fixes included. This does even compile (and work) now. :)
> 

It would be good to give the patches more descriptive names, currently
they all have the same subject lines, which is not really helpful.

> The userspace RNG daemon can later be updated to select the RNG through
> /sys/class/misc/hw_random/ for convenience. For now it is sufficient to
> use cat and echo -n on the sysfs attributes.  

When you're making the behaviour of hw_random configurable, maybe you could
also add an option to automatically use the current hw_random driver to
feed the /dev/random entropy pool on systems where the administrator trusts
its randomness.

	Arnd <><
