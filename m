Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265213AbUELUSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUELUSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265217AbUELUSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:18:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3721 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265213AbUELUSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:18:13 -0400
Message-ID: <40A28670.9040308@pobox.com>
Date: Wed, 12 May 2004 16:17:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up...
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu>
In-Reply-To: <20040512193349.GA14936@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>>Woah, that's new.  And wrong.  The code in include/asm-i386/param.h that
>>>says:
>>>	# define JIFFIES_TO_MSEC(x)     (x)
>>>	# define MSEC_TO_JIFFIES(x)     (x)
>>>
>>>Is not correct.  Look at kernel/sched.c for verification of this :)
>>
>>
>>Yes, that is _massively_ broken.
> 
> 
> why is it wrong?


Because drivers define that exact same symbol, in an arch-generic way.

	Jeff


