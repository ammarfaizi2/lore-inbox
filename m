Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVCXUok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVCXUok (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVCXUlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:41:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44264 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261196AbVCXUkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:40:12 -0500
Message-ID: <42432596.2090709@pobox.com>
Date: Thu, 24 Mar 2005 15:39:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: Andrew Morton <akpm@osdl.org>, David McCullough <davidm@snapgear.com>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>	 <20050323203856.17d650ec.akpm@osdl.org> <1111666903.23532.95.camel@uganda>
In-Reply-To: <1111666903.23532.95.camel@uganda>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> hw_random.c already does it using userspace daemons,
> which is bad idea for very fast HW - like VIA xstore/xcrypt 
> instructions.

This is incorrect, because it implies that a user would want to use the 
'xstore' feature at full speed -- which would dominate the CPU, 
drastically slowing down the applications that are actually doing work.

As I mentioned in another message, VIA xstore support should be removed 
from hw_random.c and moved completely to userspace rngd.

	Jeff


