Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263974AbRFNUIr>; Thu, 14 Jun 2001 16:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263988AbRFNUIh>; Thu, 14 Jun 2001 16:08:37 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:49043 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263974AbRFNUI2>;
	Thu, 14 Jun 2001 16:08:28 -0400
Message-ID: <3B2919B8.85D38801@mandrakesoft.com>
Date: Thu, 14 Jun 2001 16:08:24 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Tom Gall <tom_gall@vnet.ibm.com>
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <15145.1739.395626.842663@pizda.ninka.net>
		<200106141904.f5EJ4AD413350@saturn.cs.uml.edu>
		<15145.3254.105970.424506@pizda.ninka.net>
		<3B29137B.CA8442B8@mandrakesoft.com> <15145.5939.879723.656331@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Jeff Garzik writes:
>  > Thinking a bit more independently of bus type, and with an eye toward's
>  > 2.5's s/pci_dev/device/ and s/pci_driver/driver/, would it be useful to
>  > go ahead and codify the concept of PCI domains into a more generic
>  > concept of bus tree numbers?  (or something along those lines)  That
>  > would allow for a more general picture of the entire system's device
>  > tree, across buses.
>  >
>  > First sbus bus is tree-0, first PCI bus tree is tree-1, second PCI bus
>  > tree is tree-2, ...
> 
> If you're going to do something like this, ie. true hierarchy, why not
> make one tree which is "system", right? Use /proc/bus/${controllernum}
> ala:
> 
> /proc/bus/0/type        --> "sbus", "pci", "zorro", etc.
> /proc/bus/0/*           --> for type == "pci" ${bus}/${dev}.${fn}
>                             for type == "sbus" ${slot}
>                             ...
> 
> How about this?

ok with me.  would bus #0 be the system or root bus?  that would be my
preference, in a tiered system like this.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
