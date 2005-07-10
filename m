Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVGJW1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVGJW1S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVGJWYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 18:24:54 -0400
Received: from mail.dvmed.net ([216.237.124.58]:31414 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262144AbVGJWXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 18:23:23 -0400
Message-ID: <42D19FCA.4050408@pobox.com>
Date: Sun, 10 Jul 2005 18:23:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/82] changing CONFIG_LOCALVERSION rebuilds too much,
 for no good reason.
References: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> The following series of patches removes almost all inclusions
> of linux/version.h. The 3 #defines are unused in most of the touched files.
> 
> A few drivers use the simple KERNEL_VERSION(a,b,c) macro, which is unfortunatly
> in linux/version.h. This define moved to linux/utsname.h
> 
> There are also lots of #ifdef for long obsolete kernels, this will go as well.

I agree with most of the changes (and I say "most" simply because I 
haven't reviewed all of them), but it would be better to coalesce these 
100+ patches into much smaller patch clumps.

"split your patches up" mantra can get taken too far.  We want -logical 
changes- separated out, and your patches are largely a single logical 
change (remove old code).

	Jeff



