Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbTDHCPT (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 22:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbTDHCPT (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 22:15:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263886AbTDHCPS (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 22:15:18 -0400
Message-ID: <3E923390.9010206@pobox.com>
Date: Mon, 07 Apr 2003 22:27:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: zwane@linuxpower.ca, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: SET_MODULE_OWNER?
References: <20030408021239.1155C2C4EE@lists.samba.org>
In-Reply-To: <20030408021239.1155C2C4EE@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <3E91C398.9070400@pobox.com> you write:
> 
>>Rusty Russell wrote:
>>
>>>I thought it was completely useless, hence deprecated.
>>>
>>>Anyone have any reason to defend it?
>>
>>
>>It's used to allow source compatibility with all kernels, old or new.
>>
>>Thus it is in active use, and should not be removed.
> 
> 
> Inside individual drivers, or a set of compat macros, it makes sense.
> But as a general module.h primitive it doesn't.
> 
> Imagine a structure adds an owner field in 2.5.  This macro doesn't
> help you, you need a specific compat macro for that struct.

no, SET_MODULE_OWNER is quite intentionally independent of the struct. 
It only requires a consisnent naming in the source, between structures 
that may use the macro.

That's a feature.


> ie. AFAICT it only buys you 2.2 compatibility, and even then only if
> you #define it at the top of your driver.

no, farther back than that, to infinity and beyond :)  The idea of the 
macro is that on earlier kernels, it is simply a no-op, and module 
refcounting is handled by other means.


> I still don't understand: please demonstrate a use in existing source.

demonstrate?  grep for it.  It's used quite a bit.  Removal of 
SET_MODULE_OWNER looks to me to be pointless churn for negative gain. 
If if you wish to pointedly ignore the old-source compatibility angle, 
it is a nice convenience macro.

	Jeff



