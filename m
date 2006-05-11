Return-Path: <SRS0=eZZ0=67=vger.kernel.org=linux-kernel-owner@srs.kundenserver.de>
thread-index: AcZ1M4On8jDGSBO8QW26GdUcR7Pxqw==
Delivery-Date: Thu, 11 May 2006 21:29:15 +0200
Date: Thu, 11 May 2006 21:45:53 +0200
From: "Francois Romieu" <romieu@fr.zoreil.com>
Message-ID: <000001c67533$83a77710$0b64a8c0@mehnertedv.local>
Cc: "Daniel Walker" <dwalker@mvista.com>, <akpm@osdl.org>,
        <edward_peng@dlink.com.tw>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] dl2k: use explicit DMA_48BIT_MASK
References: <200605101812.k4AICpRo006555@dwalker1.mvista.com> <20060510185718.GA25334@electric-eye.fr.zoreil.com> <20060510235215.GC26617@us.ibm.com>
MIME-Version: 1.0
X-Mailer: Microsoft CDO for Exchange 2000
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20060510235215.GC26617@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
To: <unlisted-recipients:@osdl.org>, <no.To-header.on.input@osdl.org>,
        "IMB Recipient 1" <mspop3connector.stefan@mehnert-edv.de>
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
X-OriginalArrivalTime: 11 May 2006 19:45:54.0140 (UTC) FILETIME=[83C8E1C0:01C67533]
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:5df3490ebbf8888d64f9643250eb1e65

Jon Mason <jdmason@us.ibm.com> :
[...]
> DMA_*BIT_MASK is intended to be used in the DMA_API's checking of
> DMA controller's addressable memory, where as this is masking off the
> lower 48bits of a descriptor for its DMA address.  

Imho it's the specific reason why the DMA_*BIT_MASK applies here: the
code is already in dma-"tainted" land.

> I think a better solution (which I should've done when I pushed the
> original patch) would be a driver specific #define.  

$ find drivers -type f | xargs grep -i [^f]ffffffffffff[^f] | wc -l
12

No disagreement: it does not have a huge potential for code duplication.

-- 
Ueimor
