Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSAaBRI>; Wed, 30 Jan 2002 20:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290795AbSAaBQ7>; Wed, 30 Jan 2002 20:16:59 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:42465 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290794AbSAaBQm>;
	Wed, 30 Jan 2002 20:16:42 -0500
Date: Wed, 30 Jan 2002 20:16:40 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH] Fix rocket port driver
Message-ID: <20020130201640.A18730@havoc.gtf.org>
In-Reply-To: <20020131003130.A1413@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131003130.A1413@averell>; from ak@muc.de on Thu, Jan 31, 2002 at 12:31:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 12:31:30AM +0100, Andi Kleen wrote:

Cool.


> @@ -2042,6 +2046,10 @@
>  			PCI_DEVICE_ID_RP8M, i, &bus, &device_fn)) 
>  			if(register_PCI(count+boards_found, bus, device_fn))
>  				count++;
> +		if(!pcibios_find_device(PCI_VENDOR_ID_RP,
> +			0x8, i, &bus, &device_fn)) 
> +			if(register_PCI(count+boards_found, bus, device_fn))
> +				count++;	

Would it be possible to beg and plead and convince you to convert this
driver to the new PCI API?

It hasn't been touched in ages AFAICS, and both 2.4 as well as 2.5 would
greatly benefit from such a [tested] change.

	Jeff



