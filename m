Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266094AbRF2Olw>; Fri, 29 Jun 2001 10:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbRF2Oln>; Fri, 29 Jun 2001 10:41:43 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:9224 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266094AbRF2Ole>;
	Fri, 29 Jun 2001 10:41:34 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs 
In-Reply-To: Your message of "Fri, 29 Jun 2001 15:30:36 +0100."
             <20010629153036.A10196@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Jun 2001 00:41:27 +1000
Message-ID: <27957.993825687@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2001 15:30:36 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>On Sat, Jun 30, 2001 at 12:21:09AM +1000, Keith Owens wrote:
>> Create arch/Config.in which contains
>> 
>>   define_bool CONFIG_ARCH_i386 n
>>   define_bool CONFIG_ARCH_ia64 n
>>   define_bool CONFIG_ARCH_sparc n
>> 
>> etc., then change each of the arch/xxx/Config.in files to
>> source arch/Config.in as their first line first.
>
>I'd rather that we fixed dep_* so that undefined symbols were treated as
>'n', just like the makefiles treat undefined symbols.

make config and oldconfig are shell scripts.  They are limited to what
shells can do which includes "undefined variables are null", the
variable expansion is done before tristate and friends are invoked.
Of course, you could rewrite bash ...

Just put this down as one of the many "interesting" features of CML1,
put a band aid on it and move on to CML2.

