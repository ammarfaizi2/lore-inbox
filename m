Return-Path: <linux-kernel-owner+w=401wt.eu-S932812AbXASSDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812AbXASSDH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 13:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932831AbXASSDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 13:03:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:27095 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932812AbXASSDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 13:03:04 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FeX+1zaIWff2CEsI4dDDdudv1OatGwCmJT+YO9fYBk+Gc/Mm0lZM+pyYQ3t7S1jJdKh8soEUh5GJFV74cfXdezrgq/D2HOkjNB//EGOnhiPhg+p92sRuy3wcfhZCRbnb2Gt7g8drbEXDmMskNEXf1ISxujjL9Cym9WGGNvftHDw=
Message-ID: <305c16960701191003k3e69cf65o135cc2a9b1249943@mail.gmail.com>
Date: Fri, 19 Jan 2007 16:03:01 -0200
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Len Brown" <lenb@kernel.org>
Subject: Re: BUG: linux 2.6.19 unable to enable acpi
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Luming Yu" <luming.yu@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <200701190336.20236.lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <305c16960701162001j5ec23332hcd398cbe944916e1@mail.gmail.com>
	 <200701170408.54220.lenb@kernel.org>
	 <305c16960701171310v727963aevd4f29eba34316ed9@mail.gmail.com>
	 <200701190336.20236.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/07, Len Brown <lenb@kernel.org> wrote:
> I guess I'm losing my mind, because when I read this code,
> there are only two ways out of the while(retry) loop.
> Either return with success, or retry is 0.
> So how the heck is retry printed as 142?!
>
> did you notice any delay between the last two lines of printout above?
>
> please boot with "acpi_dbg_layer=2" "acpi_dbg_level=0xffffffff"
> so that we can see each read and write of the hardware look like.
> Success is measured here by looking for SCI_EN being set
> to indicate that we successfully entered ACPI mode.
>
> I guess we should see about 142 reads looking for SCI_EN...
>
> It would be interesting if you could boot a windows disk on this box
> to see if they are able to get into ACPI mode.  You'd be able to
> tell by dumping the interrupt list, looking at the device tree,
> or observing if the power button gives immediate poweroff
> or does an OS shutdown.
>
> thanks,
> -Len

printk("ACPI: retry %d\n") -> printk("ACPI: retry %d\n", retry)
;)
ill try this again soon.
