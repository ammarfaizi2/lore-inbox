Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWGTQs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWGTQs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 12:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWGTQs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 12:48:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:10916 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750711AbWGTQsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 12:48:25 -0400
X-IronPort-AV: i="4.07,163,1151910000"; 
   d="scan'208"; a="68183290:sNHT581916580"
Message-ID: <44BFB288.5000105@intel.com>
Date: Thu, 20 Jul 2006 09:42:48 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060617)
MIME-Version: 1.0
To: Mark McLoughlin <markmc@redhat.com>
CC: jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: e1000: Problem with "disable CRC stripping workaround" patch
References: <1153411868.2758.34.camel@localhost.localdomain>
In-Reply-To: <1153411868.2758.34.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jul 2006 16:43:45.0730 (UTC) FILETIME=[AADC5A20:01C6AC1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark McLoughlin wrote:
> Hi Jesse,
> 	I just came across this:
> 
>   http://www.mail-archive.com/netdev@vger.kernel.org/msg14547.html
> 
> 	I'm seeing a problem with this currently under Xen's bridging
> configuration.


 > 	One option is to fix this specific problem is to subtract the CRC
 > length from skb->len in e1000, another is to raise the MTU on the
 > receive side of Xen's loopback interface. I've attached a patch for the
 > latter, but I've no real opinion on which is more correct.

We were sort of expecting this and sent the following patch upstream already - 
it's already queued for 2.6.18-rc3:

http://kernel.org/git/?p=linux/kernel/git/jgarzik/netdev-2.6.git;a=commitdiff_plain;h=f235a2abb27b9396d2108dd2987fb8262cb508a3;hp=d3d9e484b2ca502c87156b69fa6b8f8fd5fa18a0

Please give it a try and let us know if it fixes the issue for you, it should 
be much better than patching xen's code.

Cheers,

Auke
