Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267759AbUHJVyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267759AbUHJVyh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267763AbUHJVyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:54:37 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:64948 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S267759AbUHJVye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:54:34 -0400
Message-ID: <41194431.6010300@dgreaves.com>
Date: Tue, 10 Aug 2004 22:54:57 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luesley, William" <william.luesley@amsjv.com>
Cc: "'Paul Jakma'" <paul@clubi.ie>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Network routing issue
References: <22CE8E75BE6AD3119A9800508B0FF7E9030BADD7@nmex02.nm.dsx.bae.co.uk>
In-Reply-To: <22CE8E75BE6AD3119A9800508B0FF7E9030BADD7@nmex02.nm.dsx.bae.co.uk>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>You're on the wrong track. C doesnt even need IP addresses, two 
>>choices:
>>    
>>
>>- C as bridge and use ebtables (C doesnt even need addresses 
>>theoretically)
>>    
>>
>>- C as router, use iptables. C needs one or more addresses which must 
>>be different.
>>    
>>
>My problem is I need to modify the messages before passing them on.  As far
>as I'm aware, bridges don't do that - but then I'm a newbie when it comes to
>bridging!
>  
>
http://www.spinics.net/lists/netfilter/msg13455.html

http://ebtables.sourceforge.net/documentation.html

I don't know if it will do what you want 'out of the box'

if not then the sensible thing to do would be to route and setup:

          A ------------ C  C  ---------- B
192.168.1.1    192.168.1.2  192.168.2.1   192.168.2.2

and use iptables to do user space packet filtering.

http://www.netfilter.org/documentation/HOWTO//netfilter-hacking-HOWTO-4.html#ss4.7
http://www.lowth.com/howto/iptables-treasures.php

I saw that ebtables can use iptables modules (with some hacking)

David

