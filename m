Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263318AbVCKCgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263318AbVCKCgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVCKCgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:36:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:62650 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263318AbVCKCgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:36:06 -0500
Date: Thu, 10 Mar 2005 18:37:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
In-Reply-To: <20050311021248.GA20697@redhat.com>
Message-ID: <Pine.LNX.4.58.0503101837020.2530@ppc970.osdl.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
 <20050311021248.GA20697@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Mar 2005, Dave Jones wrote:
> 
>  >  	/* ARQSZ - Set the value to the maximum one.
>  > @@ -642,11 +638,6 @@
>  >  			return 0;
>  >  		}
>  >  		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
>  > -		if (!cap_ptr) {
>  > -			pci_dev_put(device);
>  > -			continue;
>  > -		}
>  > -			cap_ptr = 0;
>  >  	}
> 
> This part I'm not so sure about.
> The pci_get_class() call a few lines above will get a refcount that
> we will now never release.

That's the part I rewrote in my version, I think that one is good.

		Linus
