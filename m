Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUIDTGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUIDTGY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 15:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUIDTGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 15:06:24 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:41586 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265817AbUIDTGX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 15:06:23 -0400
Message-ID: <413A1240.3030405@cs.aau.dk>
Date: Sat, 04 Sep 2004 21:06:40 +0200
From: =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040814)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: umbrella-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
References: <200409040241.i842fZxa003725@localhost.localdomain>
In-Reply-To: <200409040241.i842fZxa003725@localhost.localdomain>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just forgot something:

Horst von Brand wrote:
>>                                                  furthermore, you could 
>>specify that attachments executed _from_ the emailprogram would not have 
>>access to the network.
> 
> 
> I.e., no child of the email program could access the network, not even to
> answer a message. Sounds restrictive.
You misunderstood this. The restrictions are introduced by a "restricted 
fork", to which you specify the restrictions the mext process should 
have + those inherited from the parent. So if you execute an attachment 
from the thread that views the email, THIS should be restricted from 
e.g. addressbook and network.

Anyway, when you answer a message - in most cases you put the message in 
an "outbox", which the main thread of the mail program sends, when told 
to, and as the main thread is not restricted from the network 
(supprise!) it will succeed in sending the mails.
