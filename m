Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbUJYUab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbUJYUab (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbUJYU34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:29:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6370 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261295AbUJYUUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:20:51 -0400
Message-ID: <417D6011.2040003@pobox.com>
Date: Mon, 25 Oct 2004 16:20:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Hanna Linder <hannal@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Compile breakage from me
References: <417D325B.8060009@pobox.com> <Pine.LNX.4.58.0410251012090.27766@ppc970.osdl.org> <Pine.LNX.4.58.0410251024290.27766@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410251024290.27766@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 25 Oct 2004, Linus Torvalds wrote:
> 
>>How about just sending me the for_each_pci_dev() macro instead?
> 
> 
> Never mind. I just picked it up directly from my kernel mailing list
> archives instead - Hanna had already signed off on it.

hmmmm, so where do the 'gotten' references go?


> --- a/drivers/char/hw_random.c  2004-10-25 16:18:50 -04:00
> +++ b/drivers/char/hw_random.c  2004-10-25 16:18:50 -04:00
> @@ -581,7 +581,7 @@
>         DPRINTK ("ENTER\n");
>  
>         /* Probe for Intel, AMD RNGs */
> -       while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
> +       for_each_pci_dev(pdev) {


> +#define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)


	Jeff


