Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132261AbQLNKnf>; Thu, 14 Dec 2000 05:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132307AbQLNKnZ>; Thu, 14 Dec 2000 05:43:25 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11536 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132261AbQLNKnS>; Thu, 14 Dec 2000 05:43:18 -0500
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
To: gibbs@scsiguy.com (Justin T. Gibbs)
Date: Thu, 14 Dec 2000 10:14:51 +0000 (GMT)
Cc: shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
In-Reply-To: <200012140356.eBE3u8s42047@aslan.scsiguy.com> from "Justin T. Gibbs" at Dec 13, 2000 08:56:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146VPa-00044k-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll update my patch tomorrow to restore the definition of current.
> I do fear, however, that this will perpetuate the polution of the
> namespace should "current" ever get cleaned up.

It can probably get cleaned up after 2.4 by making current() the actual 
inline. For 2.2 it won't change. Consider it a feature.

It was done originally because the 2.0 code using #define based current
generated better code than using inline functions. 2.2 upwards use a different
(far nicer) method to find current.

Note also that you cannot rely on 'get_current()'. The only way to find 
current is to use current. get_current() the inline is an x86ism.

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
