Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264748AbUD1L1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264748AbUD1L1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 07:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbUD1L1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 07:27:47 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:19980 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264723AbUD1L1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 07:27:00 -0400
Message-ID: <408F9557.8080506@aitel.hist.no>
Date: Wed, 28 Apr 2004 13:28:23 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Adam Jaskiewicz <ajjaskie@mtu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca> <408E9771.7020302@mtu.edu> <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com>
In-Reply-To: <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Boucher wrote:
> 
> Hi Adam,
> 
> On Apr 27, 2004, at 1:25 PM, Adam Jaskiewicz wrote:
> 
>>
>>> Actually, we also have no desire nor purpose to prevent tainting. The 
>>> purpose
>>> of the workaround is to avoid repetitive warning messages generated when
>>> multiple modules belonging to a single logical "driver"  are loaded 
>>> (even when
>>> a module is only probed but not used due to the hardware not being 
>>> present).
>>> Although the issue may sound trivial/harmless to people on the lkml, 
>>> it was a
>>> frequent cause of confusion for the average person.
>>>
>> Would it not be better to simply place a notice in the readme 
>> explaining what
>> the error messages mean, rather than working around the liscense checking
>> code? Educate the users, rather than fibbing.
> 
> 
> Good idea. We will try to clarify the matter in the docs for the next 
> release.
> A lot of users don't read them though, so a proper fix remains necessary..

When distributing your module (with the license string fixed)
you may also distribute a kernel patch that disables the console message.
Better: you could change the logging level so the user only gets messages
in syslog and not on the console.  A customer clueless enough to be confused
by the tainting message probably don't need those other console messages either.
Users with enough clue to want these messages may then turn them on again.

Helge Hafting

