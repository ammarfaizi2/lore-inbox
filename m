Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWCZNO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWCZNO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 08:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWCZNO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 08:14:56 -0500
Received: from smtpout.mac.com ([17.250.248.87]:31434 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932079AbWCZNO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 08:14:56 -0500
In-Reply-To: <mj+md-20060326.125803.7105.albireo@ucw.cz>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com> <1143376351.3064.9.camel@laptopd505.fenrus.org> <A6491D09-3BCF-4742-A367-DCE717898446@mac.com> <mj+md-20060326.125803.7105.albireo@ucw.cz>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <50ACA1D0-C376-491A-A927-872B04964663@mac.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header	infrastructure
Date: Sun, 26 Mar 2006 08:14:08 -0500
To: Martin Mares <mj@ucw.cz>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2006, at 07:59:26, Martin Mares wrote:
> Hello!
>
>> As a result, I kinda want to stay away from anything that remotely  
>> looks like a conflicting namespace.  Using such a unique namespace  
>> means we can also safely do this if necessary (Since you can't  
>> "typedef struct foo struct bar"):
>>
>> kabi/foo.h:
>>   struct __kabi_foo {
>>   	int x;
>>   	int y;
>>   };
>>
>> linux/foo.h:
>>   #define __kabi_foo foo
>>   #include <kabi/foo.h>
>
> This looks very fragile -- <kabi/foo.h> can be included earlier by  
> another header.

It _is_ fragile, but for a number of POSIX-defined structs that's  
actually the only way to do it without duplicating the data structure  
in entirety, unless the GCC people can implement a "typedef struct  
foo struct bar;"  Hopefully it would be a relatively rare occurrence  
and carefully thought out in any case.  We may end up with some  
duplication regardless :-\.

Cheers,
Kyle Moffett

