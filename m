Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265007AbUELHNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265007AbUELHNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 03:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264995AbUELHNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 03:13:11 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:59153 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264996AbUELHNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 03:13:06 -0400
Message-ID: <40A1CEEF.5090309@aitel.hist.no>
Date: Wed, 12 May 2004 09:14:55 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jnf <jnf@datakill.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: new laptop woes
References: <Pine.BSO.4.58.0405111058520.5233@metawire.org>
In-Reply-To: <Pine.BSO.4.58.0405111058520.5233@metawire.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jnf wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Hi,
>
>The other night, I did something I know better than to do- and this is buy 
>a piece of hardware before checking out the support it has in the 
>linux/unix world. But overall I came out ok. I have a few comments and 
>questions and I will try to present them in a coherant fasion below.
>
>1) broadcom wlan cards
>
>As I understand it, broadcom has more or less refused to release 
>alot/some of the specs for some of their cards. I've done some kernel 
>programing, I wrote something that could be somewhat classified as a 
>virtual driver in the network stack I suppose- but I've never written a 
>'real' driver. So in short, beyond digging through some of the other wlan 
>drivers and getting an idea for where to start- if I wanted to attempt to 
>write a driver for this, what would be a good place to start? (I'm not 
>even totally sure how to interface with it, it doesnt appear that its even 
>being assigned an irq- but i could be wrong)
>  
>
Looking at other card drivers, you'll find out what a driver look like.
You'll learn how a card driver interfaces to the kernel.
To write a driver for this card you _need_ to know how that particular
card is programmed. (What io adresses do it use, what do they mean,
what are the timing requirements, and so on.)
Looking at other drivers won't help you with that, unless one of the
other drivers happens to use the same chips. This information is in the
specs that broadcom so far haven't released.  Of course you can
write to broadcom, perhaps they'll inform you when they see you
are serious about this.

The card is not assigned an irq precicely because it has no driver.
IRQ's aren't handed out because devices exists - they are handed
out because device drivers request them from the kernel.

Helge Hafting



