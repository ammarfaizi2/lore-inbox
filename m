Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbVHJXHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbVHJXHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbVHJXHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:07:31 -0400
Received: from mail.possibilityforge.com ([209.33.206.30]:8521 "EHLO
	possibilityforge.com") by vger.kernel.org with ESMTP
	id S932581AbVHJXHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:07:30 -0400
Message-ID: <42FA88A8.8030205@possibilityforge.com>
Date: Wed, 10 Aug 2005 17:07:20 -0600
From: Jon Scottorn <jscottorn@possibilityforge.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic 2.6.12.4
References: <006701c59de5$146f0960$a20cc60a@amer.sykes.com> <1273120000.1123714485@flay>
In-Reply-To: <1273120000.1123714485@flay>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Spam-Score: -102.6
X-Spam-Report: Spam detection software, running on the system "mail.possibilityforge.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Sorry, I actually figured it out. I had the adaptec i2o
	driver built in the kernel along with the i2o items in the main driver
	list and they were conflicting with each other. I removed the i2o items
	from the main list and now everything works good. [...] 
	Content analysis details:   (-102.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-100 USER_IN_WHITELIST      From: address is in the user's white-list
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I actually figured it out.

I had the adaptec i2o driver built in the kernel along with the i2o
items in the main driver list and they were conflicting with each
other.  I removed the i2o items from the main list and now everything
works good.

Thanks,

Jon

Martin J. Bligh wrote:

>--On Wednesday, August 10, 2005 13:52:45 -0600 Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
>
>  
>
>>>I am trying a custom 2.6.8 kernel now, and here is my
>>>2.6.12.4 .config file.
>>>Let me know what you think.
>>>      
>>>
>>I don't know much about Kernel Panics. I hope that someone that knows could
>>take a look, but so far, it looks like you need to be running Sid to have
>>this working propperly.
>>
>>Please try 2.6.8, I'm almost sure that it should work.
>>
>>And anyway, this ML is not really a user support list, try asking in a
>>debian mailing list, if they think that it's something wrong with the
>>kernel, then come back and let us know.
>>    
>>
>
>Kernel panics are fine, though you really need to give us the whole thing.
>Make sure you run it through ksymoops, or have CONFIG_KKALLSYMS or whatever
>it's called turned on.
>
>adpt_isr is in drivers/scsi/dpt_i2o.c, so you have some SCSI driver
>problem, I presume?
>
>M.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
