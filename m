Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWHIQEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWHIQEh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWHIQEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:04:37 -0400
Received: from h155.mvista.com ([63.81.120.155]:63203 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1751038AbWHIQEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:04:36 -0400
Message-ID: <44DA07D6.9010101@ru.mvista.com>
Date: Wed, 09 Aug 2006 20:05:42 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: albertl@mail.com, Mikael Pettersson <mikpe@it.uu.se>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       alan@redhat.com, Unicorn Chang <uchang@tw.ibm.com>,
       Doug Maxey <dwm@enoyolf.org>
Subject: Re: libata pata_pdc2027x success on sparc64
References: <200607172358.k6HNwYhF002052@harpo.it.uu.se>	<44BD2370.8090506@ru.mvista.com>	<44C841B5.40806@tw.ibm.com> <17626.1619.653854.241578@alkaid.it.uu.se>
In-Reply-To: <17626.1619.653854.241578@alkaid.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Mikael Pettersson wrote:

>  > The libata version has three improvements compared to the IDE version.
>  > 
>  > 1. The PLL calibration patches in the above URLs (for IDE)
>  > still need more improvement as done in the pdc_read_counter()
>  > of the libata version.
>  > 
>  > 2. The Promise 2027x adapters check the "set features - xfer mode"
>  >    and set the timing register automatically. However, the automatically
>  >    set values are not correct under 133MHz. Libata has a hook
>  >    pdc2027x_post_set_mode() to set the values back by software.
>  > 
>  > 3. ATAPI DMA is supported (please see pdc2027x_check_atapi_dma()).
>  >    Maybe we also need to add this to the IDE version.

> Do you know how large the difference is between the 20267 (old driver)
> and the 20269 (new driver) in the areas touched by these patches?

    Immense. They belong to the different families, register compatibe only in 
the standard PCI/BM IDE regisrer set -- hence was the driver split.

> Long ago I tried a 20267 PCI card in my PowerMac, and it had the same
> issues that the 20269 card had. So I'm interested in porting the
> calibration/timing fixes to pdc202xx_old.c.

    They don't apply to this driver at all.  The "older" chip family didn't 
have the PLL to calibrate.  It must be some different issue.

> /Mikael

WBR, Sergei
