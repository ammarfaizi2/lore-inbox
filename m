Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755892AbWKQUmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892AbWKQUmy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755893AbWKQUmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:42:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:34218 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1755892AbWKQUmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:42:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lkiDcHw2BvCAhbdFaObZXcCZzMy3bZcLOKCZwTHM7J7nMt8P8iF6svRc5ezAin9L5CDDe9O0syKSXVM7UdzGidhxpw632XekMvZqhsK3iqaeOgUuAAqBLrWyVDSJNdw+Ek/A4m836NtfuMkEvs/Qpb3rkZjQbEDUro6vOoNzRoI=
Message-ID: <cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com>
Date: Fri, 17 Nov 2006 21:42:50 +0100
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome LCD ?
Cc: "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45535C08.5020607@innova-card.com>
	 <Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org>
	 <cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com>
	 <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
	 <cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com>
	 <Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org>
	 <cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com>
	 <Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/06, James Simmons <jsimmons@infradead.org> wrote:
>
> Are those actually numbers? If they are the problem isn't byte reversal
> but bit shifting.
>
> 1010100 = 54
> 0101010 = 2A

It's not byte reversal, but _bits_ of each bytes have been inversed
(bit7->bit0, bit6->bit1, bit5->bit2, bit4->bit3, bit3->bit4, ...)
after calling slow_imageblit(). Is it something expected ?

> I really don't understand why fbmem.c has its own routines to handle the logo for the color > map. I can set creating a fbcmap and calling fb_set_cmap instead.

Unfortunately I cannot help you on this point...

> That will be a  separte patch.
>

Thanks
-- 
               Franck
