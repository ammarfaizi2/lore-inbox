Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbTJIRRK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 13:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTJIRRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 13:17:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38800 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262304AbTJIRRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 13:17:05 -0400
Message-ID: <3F859802.4060607@pobox.com>
Date: Thu, 09 Oct 2003 13:16:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
References: <3F858885.1070202@colorfullife.com> <3F858EF8.5080105@pobox.com>	 <1065718629.663.3.camel@gaston>  <3F8594CD.1030504@pobox.com> <1065719227.663.6.camel@gaston>
In-Reply-To: <1065719227.663.6.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Thu, 2003-10-09 at 19:03, Jeff Garzik wrote:
> 
> 
>>Easily solved with a synchronize_irq()  ;-)
> 
> 
> No. synchronize_irq will do nothing to an irq that is
> still somewhere in the HW path from the device to the core,
> and even in the core it may be queued for some cycles before
> actually delivered.


hmmm, ok :)

Well my main objection is disable_irq+free_irq+enable_irq.  Seems to me 
we'll wind up coding around that.  Maybe a free_and_enable_irq is 
appropriate to avoid such a situation?  Oh well, just thinking out loud...

	Jeff



