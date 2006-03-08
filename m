Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWCHIce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWCHIce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 03:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWCHIcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 03:32:33 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:3984 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751469AbWCHIcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 03:32:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kk3enOcvFTjBkaCQBe4y8iifhZAB/kRC9Kigz0syWVVbyA+ppCsIDSTEl37CigNZIVlT4APSryVtY217POgj0x7wbs8kn85nNa7hR4ZntYq06wMJzOni8CbBAolAKyF004KEvz1P/NfTMueSG/kTL84BalxMkAR1584ZqiACOBY=  ;
Message-ID: <440E969B.2080301@yahoo.com.au>
Date: Wed, 08 Mar 2006 19:32:27 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       Mike Christie <michaelc@cs.wisc.edu>,
       Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
References: <200603080129_MC3-1-BA15-47C9@compuserve.com>
In-Reply-To: <200603080129_MC3-1-BA15-47C9@compuserve.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <Pine.LNX.4.64.0603061917330.3573@g5.osdl.org>
> 
> On Mon, 6 Mar 2006 19:20:13 -0800, Linus Torvalds wrote:
> 
> 
>>>When someone converted the *buffer* allocation to kzalloc they
>>>also removed the the memset for the *packet_cmmand* struct.
>>>
>>>The
>>>
>>>memset(&cgc, 0, sizeof(struct packet_command));
>>>
>>>should be added back I think.
>>
>>Good eyes. I bet that's it.
> 
> 
> Heh.  This exact fix was posted to linux-kernel by Lee Schermerhorn
> three weeks ago:
> 
>  Date: Wed, 15 Feb 2006 14:07:37 -0500
>  From: Lee Schermerhorn <lee.schermerhorn@hp.com>
>  Subject: [PATCH] 2.6.16-rc3-mm1 - restore zeroing of packet_command
>         struct  in sr_ioctl.c
>  To: linux-kernel <linux-kernel@vger.kernel.org>
>  Cc: Andrew Morton <akpm@osdl.org>
>  Message-ID: <1140030457.6619.3.camel@localhost.localdomain>
> 
> 

It isn't Andrew's job to make sure a patch gets to the right place
until it is safely in -mm, and even then he's not always going to
know the severity and importance unless he's told.

If it was a patch to "restore" a regression in behaviour, CCs should
at least have gone to the author of the patch that broke it, and the
subsystem maintainers / list / etc as well.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
