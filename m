Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270906AbTGQPqR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270938AbTGQPqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:46:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53383 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270906AbTGQPqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:46:15 -0400
Message-ID: <3F16C83A.2010303@pobox.com>
Date: Thu, 17 Jul 2003 12:00:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Schlichter <schlicht@uni-mannheim.de>
CC: ricardo.b@zmail.pt, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
Subject: Re: SET_MODULE_OWNER
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net> <3F16C190.3080205@pobox.com> <200307171756.19826.schlicht@uni-mannheim.de>
In-Reply-To: <200307171756.19826.schlicht@uni-mannheim.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter wrote:
> On Thursday 17 July 2003 17:32, Jeff Garzik wrote:
> 
>>Ricardo Bugalho wrote:
>>
>>>Hi all,
>>>  most net device drivers have replaced MOD_INC/DEC_USE_COUNT with
>>>SET_MODULE_OWNER but SET_MODULE_OWNER doesn't do nothing.
>>>  Therefore, those modules (though I can only vouch for 8139too) always
>>>report 0 use. Some people that had "modprobe -r" in their cronttab found
>>>it quite annoying.
>>>  I'd guess that there's a good reason for why struct net_device doesn't
>>>have .owner field and why this happens. Can someone be so kind to point
>>>it
>>>out?
>>
>>struct net_device does have an owner field, and SET_MODULE_OWNER
>>obviously _does_ do something.
> 
> 
> That's not correct for 2.5.x anymore...
> Have a look at Changeset 1.1167 from davem.
> 
> It removed the owner field about 9 weeks ago. That was the time where 
> SET_MODULE_OWNER became a NOP...
> 
> 
>>If your interface is up, your net driver's module refcount is greater
>>than zero.
> 
> 
> Well, as I looked now my netdevice is up, but its reference count is at 0, 
> too!

Doh.  I missed that.

David?  Does Rusty have a plan here or something?

	Jeff



