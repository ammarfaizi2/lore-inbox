Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUHYIod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUHYIod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 04:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUHYIod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 04:44:33 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:47823 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S261234AbUHYIob
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 04:44:31 -0400
Message-ID: <412C5136.3040304@ttnet.net.tr>
Date: Wed, 25 Aug 2004 11:43:34 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org, mdharm-usb@one-eyed-alien.net,
       marcelo.tosatti@cyclades.com
Subject: Re: PANIC [2.4.27] usb-storage
References: <4127AF46.6090908@ttnet.net.tr> <20040824154753.503d0fc9@lembas.zaitcev.lan>
In-Reply-To: <20040824154753.503d0fc9@lembas.zaitcev.lan>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> On Sat, 21 Aug 2004 23:23:34 +0300
> "O.Sezer" <sezeroz@ttnet.net.tr> wrote:
> 
> 
>>Unable to handle kernel paging request at virtual address e0ce6d90
> 
> 
>>>>EIP; e0ce6d90 <[usb-storage]usb_stor_CBI_irq+0/70>   <=====
> 
> 
> Something unmapped a page where the module code resided. Are you sure
> you haven't tried to run rmmod? Bad idea.
> 
> -- Pete
> 

I was pretty confident that I told this happens upon modprobe -r
or rmmod (at least in the previous messages). The problem is not
(or at least shouldn't be) rmmod:
With a "healthy" disk nothing happens upon rmmod usb-storage even
if the disk is still plugged in (you can't mount the disk, that's
what happens). With this beast, even after scsi reports it offlined
the dist, usb-uhci still tries messing with irqs; please see the
dmesg output.

Ozkan
