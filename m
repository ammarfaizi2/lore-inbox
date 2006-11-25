Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757639AbWKYBnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757639AbWKYBnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 20:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757634AbWKYBnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 20:43:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:23999 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1755447AbWKYBnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 20:43:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HOVIsSE1O0beDOvkp87B/Y7TIvTiOaYrD7/jSaVBDjiNa/DaFMdj4OlkAHZMbv0gJ0PtbzoUN8XnaTP9MbwM6D2IoIA3I/AQlb3DE0OxroL86aTPOXjdXdg+wOBJ72xH/lyDVEVAyZPU6UTDmFctAVtwDAv/KiuBYamZViCyDEo=
Message-ID: <45679FC5.8050304@gmail.com>
Date: Sat, 25 Nov 2006 10:43:33 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Conke Hu <conke.hu@amd.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       arjan@infradead.org
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA
References: <FFECF24D2A7F6D418B9511AF6F3586020108CE7D@shacnexch2.atitech.com>	<45668ACF.1040101@gmail.com>	<456699CA.9060904@gmail.com> <20061124111313.5ec0a599@localhost.localdomain>
In-Reply-To: <20061124111313.5ec0a599@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
>> * Unlike Jmicron's case, this doesn't affect PCI bus scan.  Actually, it 
>> does change class code but that's not as disruptive as Jmicron's case 
>> and as long as ahci ignores class code, it doesn't really matter. 
>> Driver can be chosen by changing loading order - this is both plus and 
>> minus.
> 
> The load order is basically undefined. You want AHCI so we should do
> this early. That means either putting the same gunk all over the kernel
> (drivers/ide, drivers/ata/*ati* drivers/ata/ahci) or in one place.
>  
>> * As Arjan pointed out, that unlock-modify-lock sequence should be done 
>> on resume too.  
> 
> The infrastructure for this is already handled by the pci resume quirk
> patches I sent. 

As long as resume is properly handled, no problem.

Thanks.

-- 
tejun
