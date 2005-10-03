Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVJCOPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVJCOPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVJCOPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:15:21 -0400
Received: from magic.adaptec.com ([216.52.22.17]:49857 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932239AbVJCOPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:15:20 -0400
Message-ID: <43413CE8.1090306@adaptec.com>
Date: Mon, 03 Oct 2005 10:15:04 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org> <433D8542.1010601@adaptec.com> <433DD0F8.4000501@pobox.com>
In-Reply-To: <433DD0F8.4000501@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2005 14:15:05.0455 (UTC) FILETIME=[DA2AE7F0:01C5C824]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/05 19:57, Jeff Garzik wrote:
> Luben Tuikov wrote:
> 
>>MPT-based drivers + James Bottomley's "transport attributes"
> 
> 
> You continue to fail to see that a transport class is more than just 
> transport attributes.
> 
> You continue to fail to see that working on transport class support IS a 
> transport layer, that includes management.
> 
> Is you don't understand this fundamental stuff, how can we expect you to 
> get it right?

>From what I see, because of its *layering* position
JB's "transport attributes" cannot satisfy open transport.

The reason is that MPT-based drivers indeed do need host template
in the LLDD.

Open Transport (SBP/USB/SAS) do not, since the chip is only
an interface to the transport.

The host template is implemented by a transport layer,
say USB Storage or the SAS Transport Layer.

This allows you to do great things, like layer
intersection.

	Luben
