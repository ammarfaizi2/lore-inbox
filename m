Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbTANRlk>; Tue, 14 Jan 2003 12:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbTANRlk>; Tue, 14 Jan 2003 12:41:40 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:47346 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S264853AbTANRlk>; Tue, 14 Jan 2003 12:41:40 -0500
Message-ID: <3E244D96.4040008@google.com>
Date: Tue, 14 Jan 2003 09:49:10 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Alan Cox <alan@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
References: <200301131946.h0DJk1w32012@devserv.devel.redhat.com> <1042565893.587.66.camel@zion.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>Ok, but PIIX runs on intel platforms with real IOs, so there is no need
>to perform a read... If we go the hwif->IOSYNC() way, we might well set
>it up to no-op on x86 PIO iops by default and read of alt-status on
>other archs if it's safe enough on other controllers/drives...
>
I believe that this will corrupt any inprogress UDMA transfer on the 
promise 20265 chip and probably others.  It would be better to read the 
dma registers for the Promise controllers.

    Ross


