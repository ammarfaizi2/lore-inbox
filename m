Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbULER6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbULER6T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbULER6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:58:19 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:14483 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261339AbULER6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:58:12 -0500
Message-ID: <41B34C25.3060500@colorfullife.com>
Date: Sun, 05 Dec 2004 18:57:57 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Stuff <kernel-stuff@comcast.net>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] Document kfree and vfree NULL usage (resend)
References: <Pine.LNX.4.44.0412051628280.13644-100000@dbl.q-ag.de> <200412051105.10934.kernel-stuff@comcast.net> <41B33E70.2000107@colorfullife.com> <200412051244.36449.kernel-stuff@comcast.net>
In-Reply-To: <200412051244.36449.kernel-stuff@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Stuff wrote:

>The attached patch changes the vfree() documentation to correct "May not be 
>called in interrupt context" to "Must not be called in interrupt context". 
>Latter is compliant to  RFC2119 and matches the absolute requirement for  
>vfree.
>
>Is not the same requirement true for vmalloc() - or is it ok to call vmalloc() 
>in interrupt?
>
>  
>
No, it's not ok.
But that's not something worth mentioning: only a few functions are 
permitted from interrupt context. The special thing about vfree is the 
asymmetry: kfree from irq context is ok, vfree is forbidden. That's why 
it's documented.

--
    Manfred
