Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUE1Rkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUE1Rkd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbUE1Rkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:40:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46488 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263761AbUE1Rka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:40:30 -0400
Message-ID: <40B7797F.2090204@pobox.com>
Date: Fri, 28 May 2004 13:40:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
References: <7F740D512C7C1046AB53446D372001730182BAE2@scsmsx402.amr.corp.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D372001730182BAE2@scsmsx402.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:
> Today Linux is used for various configurations, including the ones that
> substantially limit the set of user commands, libraries, etc. So we want
> to keep it.


With all due respect, "it might be an embedded box" is not normally a 
reason why we keep stuff in the kernel.  With initramfs et. al., we are 
actively moving in the opposite direction.

If this was the only reason for having kirqd in the kernel, it would be 
long gone.

The reason why kirqd hasn't been removed is simply because nobody has 
stepped up to do a apples-to-apples comparison to prove that userland 
irqbalanced has any performance advantages, or disadvantages, over 
kirqd.  From a hard-numbers perspective, compared to kirqd, the userland 
solution is still largely an unknown quantity.

irqbalanced makes a lot of sense from a flexibility and policy 
perspective, and it works on multiple arches, so it has a lot more going 
for it.

"We like it in the kernel so we don't have to ship a userland component" 
is not a valid reason.

	Jeff


