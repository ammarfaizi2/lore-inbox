Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUGYBcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUGYBcD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 21:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUGYBcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 21:32:03 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:62662 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S263540AbUGYBb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 21:31:59 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: root@chaos.analogic.com, Mikael Pettersson <mikpe@csd.uu.se>,
       jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: 2.4.27+stdarg+gcc-3.4.1 
In-reply-to: Your message of "Sun, 25 Jul 2004 01:27:55 +0300."
             <200407250127.55782.vda@port.imtp.ilyichevsk.odessa.ua> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 25 Jul 2004 11:31:46 +1000
Message-ID: <5983.1090719106@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004 01:27:55 +0300, 
Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
>On Saturday 24 July 2004 17:59, Keith Owens wrote:
>> On Sat, 24 Jul 2004 09:19:04 -0400 (EDT),
>>
>> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
>> >> >gcc -D__KERNEL__ -nostdinc -iwithprefix include
>> >
>> >                     ^^^^^^^_______
>> >
>> >This will prevent it from using its private copy of stdarg.h.
>> >
>> >There needs to be one in the -I<include-path>
>>
>> No.  -iwithprefix include picks up the private path.  It is probably a
>> misconfigured gcc, but I am waiting on detailed diagnostics to be sure.
>
>I have such 'misconfigured' gcc for a very long time.
>I compiled a lot of stuff with it.
>
>Nothing complains except the kernel.

Only the kernel adds '-nostdinc -withprefix include'.
 
>GCC_EXEC_PREFIX=/usr/app/gcc-3.3.3/lib/gcc-lib/
>
>fixes it for me.

Which makes it a local gcc build problem.  I run 3.3.3 and it handles
-nostdinc -iwithprefix include correctly.  Compile init/do_mounts.c
with gcc -v to get the list of include paths for your version of gcc,
stdarg.h will not be on those paths.  Rebuild your version of gcc with
the correct paths.

