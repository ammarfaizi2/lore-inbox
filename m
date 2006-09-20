Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751920AbWITQvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbWITQvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbWITQvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:51:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:51959 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751920AbWITQv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:51:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MqA6BFOx17+bSRY7wUNwL2Gg1dNNT3WpX+jm1Z3i4tFVuYg+ath6xdpP1C3PvdOP02gVCrhEXSL3U3wsNf75G7jFpvpNIz4lwh5Gnj5OQ3QbG07Cv2WdnZJZ9kYBaVI45mViIHgVueg5vJQaM3+A3eFAoa3b3CNEO8x9DkZbLZY=
Message-ID: <8b96e3d20609200951h6b70c261odff1db1913d13d10@mail.gmail.com>
Date: Wed, 20 Sep 2006 13:51:28 -0300
From: "Luiz Angelo Daros de Luca" <luizluca@gmail.com>
To: "Jarek Poplawski" <jarkao2@o2.pl>
Subject: Re: [PATCH] Adds kernel parameter to ignore pci devices
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <20060920112559.GC1697@ff.dom.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060920064114.GA1697@ff.dom.local>
	 <1158748734.7705.4.camel@localhost.localdomain>
	 <20060920112559.GC1697@ff.dom.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allan, disabling EHCI in kernel won't solve it cause the kernel
freezes when linux is setting up pci. This is before any device
specific driver and it is done even without any driver for that
device.

I was going to implement a way to ignore using bus+board+function but
not at this time. BTW, are the parameters name, format and debug
messages adequated to kernel's principels?


2006/9/20, Jarek Poplawski <jarkao2@o2.pl>:
> On Wed, Sep 20, 2006 at 11:38:53AM +0100, Alan Cox wrote:
> > Ar Mer, 2006-09-20 am 08:41 +0200, ysgrifennodd Jarek Poplawski:
> > > On 20-09-2006 02:01, Alan Cox wrote:
> > > > Not sure its the way I'd approach it - in your specific case it should
> > > > be easier to just not compile in EHCI (USB 2.0) support.
> > >
> > > I'd dare to vote for this idea: it's good for testing
> > > and very practical eg. for comparing performance of similar
> > > devices like network or sound cards. Besides: ehci could
> > > work for other devices.
> >
> > In which case you'd need to specify the device to ignore by its PCI bus
> > address so could ignore one device but not another of the same type. Eg
> > pci=ignore=0:4.5
>
> If I correctly understand this as a doubt I mean doing this in grub
> or lilo as boot variants.
>
> Jarek P.
>


-- 
      Luiz Angelo Daros de Luca
            luizluca@gmail.com
              ICQ: 19290419

 I Know, "Where you wanted to go today",
    but I decided to stop here instead!
                        MS Windows
