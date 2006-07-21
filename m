Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbWGUIw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWGUIw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 04:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbWGUIw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 04:52:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42977 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030413AbWGUIw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 04:52:27 -0400
Subject: Re: e1000: Problem with "disable CRC stripping workaround" patch
From: Mark McLoughlin <markmc@redhat.com>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <44BFB288.5000105@intel.com>
References: <1153411868.2758.34.camel@localhost.localdomain>
	 <44BFB288.5000105@intel.com>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 09:51:35 +0100
Message-Id: <1153471895.8519.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-07-20 at 09:42 -0700, Auke Kok wrote:
> Mark McLoughlin wrote:
> > Hi Jesse,
> > 	I just came across this:
> > 
> >   http://www.mail-archive.com/netdev@vger.kernel.org/msg14547.html
> > 
> > 	I'm seeing a problem with this currently under Xen's bridging
> > configuration.

>  > 	One option is to fix this specific problem is to subtract the CRC
>  > length from skb->len in e1000, another is to raise the MTU on the
>  > receive side of Xen's loopback interface. I've attached a patch for the
>  > latter, but I've no real opinion on which is more correct.
> 
> We were sort of expecting this and sent the following patch upstream already - 
> it's already queued for 2.6.18-rc3:
> 
> http://kernel.org/git/?p=linux/kernel/git/jgarzik/netdev-2.6.git;a=commitdiff_plain;h=f235a2abb27b9396d2108dd2987fb8262cb508a3;hp=d3d9e484b2ca502c87156b69fa6b8f8fd5fa18a0
> 
> Please give it a try and let us know if it fixes the issue for you, it should 
> be much better than patching xen's code.

	Yep, this fixes the problem for me.

Thanks,
Mark.

