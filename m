Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVA0UuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVA0UuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVA0Urf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:47:35 -0500
Received: from [204.127.202.56] ([204.127.202.56]:60834 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261184AbVA0UpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:45:15 -0500
Message-ID: <41F952EA.4060202@comcast.net>
Date: Thu, 27 Jan 2005 15:45:30 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org> <41F92721.1030903@comcast.net>  <1106848051.5624.110.camel@laptopd505.fenrus.org>  <41F92D2B.4090302@comcast.net>  <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>  <Pine.LNX.4.61.0501271414010.23221@chaos.analogic.com> <1106856178.5624.128.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0501271505190.23334@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501271505190.23334@chaos.analogic.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


So 0x02020202 is a no-op?

(somebody finally gets why the randomization range must be > the size of
the stack?)

linux-os wrote:
[...]

>> pointing back into that buffer needs the address of that buffer. That
>> buffer is on the stack, which is now randomized.
>>
> 
> Wrong concept. Your exploit program simply needs fill with a guad-
> byte offset such as 0x02020202 and put your payload at that
> offset. You don't care where the stack-pointer is. You find
> out how many bytes of 0x02 are necessary to get to that offset
> on an experimental system, it is independent of the stack-pointer
> value. It depends only upon the size of the buffer you are
> exploiting, which needs to not change, of course.
> 
> When the return instruction occurs, one of those 0x02020202
> will be encountered and your payload gets executed next.
> 
> Note that you should chose a different repeating-byte
> than I have used here. Get the address of _end on a 'C'
> program for hints.
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction.
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+VLphDd4aOud5P8RAv5YAJ0QEBPyP+KMRS1Ua184KGJo3cw9EQCfc03J
SwDI0Zae2W5L03xHLXIkDdg=
=1+Xl
-----END PGP SIGNATURE-----
