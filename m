Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVJCQCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVJCQCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVJCQCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:02:05 -0400
Received: from mail.dvmed.net ([216.237.124.58]:29340 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932338AbVJCQCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:02:01 -0400
Message-ID: <434155EC.6080100@pobox.com>
Date: Mon, 03 Oct 2005 12:01:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org> <433D8542.1010601@adaptec.com> <A0262C6F-6B0E-4790-BA42-FAFD6F026E0A@mac.com> <433D8D1F.1030005@adaptec.com> <0F03AA4B-D2D1-4C57-B81B-FC95CB863A98@mac.com> <433DB8AF.4090207@adaptec.com> <433DD95C.5050209@pobox.com> <43413D9C.2050904@adaptec.com>
In-Reply-To: <43413D9C.2050904@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> On 09/30/05 20:33, Jeff Garzik wrote:
>>This is a misrepresentation.  -We- understand the stuff you have posted.
>>
>>But you continue to demonstrate that you simply do not understand the 
>>existing SCSI core code.
>>
>>The SAS transport class supports commonality across all SAS 
>>implementations.  This includes both MPT and Adaptec 94xx.
>>
>>SAS transport class + libsas supports software implementations of SAS, 
>>including transport layer management.  This includes Adaptec 94xx but 
>>NOT MPT.
> 
> 
> You almost get it right, other than the layering infrastructure.
> 
> The SAS Transport Layer is a layer in its own right.  It is not
> a "libsas".

Different open transport hardware will expose the underlying network at 
different levels.

Hardware A might provide direct access to SSP and IDENTIFY/CONNECT frame 
handling, while Hardware B may handle that internally, while still 
providing full SMP access for the transport layer to discovery topology 
and build its routing table.

We cannot assume that all open transport hardware will function the 
same, hence the better approach is a library of helpers that function in 
concert with LLDD to form a transport layer.


> MPT and open transport a very different, one hides the transport,
> i.e. the transport layer is in firmware; the other exposes it

For the 1001th time, we know all this.

	Jeff



