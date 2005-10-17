Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVJQRDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVJQRDt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVJQRDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:03:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:52878 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750923AbVJQRDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:03:48 -0400
Message-ID: <4353D96F.90805@pobox.com>
Date: Mon, 17 Oct 2005 13:03:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       davej@redhat.com
Subject: Re: [PATCH] libata: fix broken Kconfig setup
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org> <200510170952.34174.jbarnes@virtuousgeek.org>
In-Reply-To: <200510170952.34174.jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> It does, since it prevents one of the ports from being bound by the 
> legacy IDE driver.  But the whole thing is rather hackish to begin with, 
> and I prefer this hack to the existing code (in fact, Andrew already 
> queued up a patch from me in -mm that looks just like yours).
> 
> Ultimately, when libata gets ATAPI support, I think we just have to 
> declare libata and legacy IDE to be incompatible for combined mode 
> devices and remove the quirk.  Then whichever driver loads first will 
> get the whole device, as it should.

I would love to remove the quirk completely!

Unfortunately combined mode is a runtime BIOS configuration, and there 
is also the lockup issue I mentioned in another email.

	Jeff


