Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266161AbUHFT23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbUHFT23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268244AbUHFT1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:27:09 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:63632 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S268248AbUHFT0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:26:05 -0400
Message-ID: <4113DC15.8040102@am.sony.com>
Date: Fri, 06 Aug 2004 12:29:25 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Mark Lord <lkml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dsingleton@mvista.com
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com> <1091226922.5083.13.camel@localhost.localdomain> <410AEDC8.6030901@pobox.com> <410FCF9A.0@rtr.ca> <4113A839.40603@pobox.com>
In-Reply-To: <4113A839.40603@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Honestly, this is what I would prefer:  leave drivers/ide probing alone. 
>    As we say in the South, "if it ain't broke, don't fix it"
> 
> Long term, migrate to libata which should provide quite rapid PATA probing.

Thanks.  This is helpful information.  I will check into libata.

With regard to brokenness, for many consumer products, there is a
strong desire that they boot in under 1 second.  The general
agreement among CELF members is that we'd like to see the
kernel booting in under 500 milliseconds.  This is just not
possible with the current long IDE probes.

Our current testing seems to indicate that shortened delays
will not be a problem for the hardware being considered for
use in current CE products.  I can appreciate that shortened
delays are problematical for the wider kernel audience.
(I feel compelled to point out that the current patch
doesn't change the delays.)

It appears that this change won't be accepted.  That's OK.  We'll
maintain a patch at CELF for interested parties, and try to document
the caveats from this thread (and from additional testing) to try
to avoid problems.  Also, we'll check into the other mechanisms
for probe reduction discussed in this thread, and come back if we
find some promising bits.

Thanks for everyone that responded.

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
