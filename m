Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSHHMPo>; Thu, 8 Aug 2002 08:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317340AbSHHMPo>; Thu, 8 Aug 2002 08:15:44 -0400
Received: from hermes.domdv.de ([193.102.202.1]:14603 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S316887AbSHHMPn>;
	Thu, 8 Aug 2002 08:15:43 -0400
Message-Id: <m17cmFU-003oZpC@zeus.domdv.de>
Date: Thu, 8 Aug 2002 14:19:48 +0200 (CEST)
From: Andreas Steinmetz <ast@domdv.de>
Subject: Re: [OT] 2.4.19 BUG in page_alloc.c:91
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@conectiva.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
References: <3D51DB52.6000200@verizon.net>
 <1028810336.28882.18.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1028810336.28882.18.camel@irongate.swansea.linux.org.uk>
Organization: D.O.M. Datenverarbeitung GmbH
X-Mailer: Mahogany 0.64 'Sparc', compiled for Linux 2.4.15 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Aug 2002 13:38:56 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

Rik and Alan,
not exactly related but please don't be too persistent about "Tainted: P".
Just try to insmod xircom_tulip_cb of a stock 2.4.19 kernel and, surprise:

# insmod xircom_tulip_cb
Using /lib/modules/2.4.19/kernel/drivers/net/pcmcia/xircom_tulip_cb.o
Warning: loading
/lib/modules/2.4.19/kernel/drivers/net/pcmcia/xircom_tulip_cb.o will taint the 
kernel: non-GPL license - GPL v2

The result of trying to load the module even with no card inserted results
in "Tainted: P" (modutils-2.4.14).

As long as the current stock kernel isn't completely compliant to the new
rules (e.g. drivers/net/pcmcia/xircom_tulip_cb.c) and as long as it cannot
be assumed that everybody is running the latest modutils it should not be
assumed that anybody has loaded a proprietary module by default.

That's no criticism of the nvidia handling (I don't own such a card), it is
more the new "P=must be proprietary" attitude I don't exactly like.


