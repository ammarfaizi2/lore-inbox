Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281404AbRKZCUR>; Sun, 25 Nov 2001 21:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281411AbRKZCUH>; Sun, 25 Nov 2001 21:20:07 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:49929 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281404AbRKZCUC>;
	Sun, 25 Nov 2001 21:20:02 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-final drivers/net/bonding.c includes user space headers 
In-Reply-To: Your message of "Sun, 25 Nov 2001 18:09:05 -0800."
             <3C01A441.6070702@zytor.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Nov 2001 13:19:50 +1100
Message-ID: <1595.1006741190@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001 18:09:05 -0800, 
"H. Peter Anvin" <hpa@zytor.com> wrote:
>Keith Owens wrote:
>>   bonding.c includes limits.h, picked up from gcc, OK.
>>   limits.h includes syslimits.h from gcc, OK.
>>   syslimits.h tries to include_next <limits.h> to get the user space
>>   limits, not OK.
>> 
>> Any kernel code that includes limits.h or syslimits.h is polluted by
>> user space headers.  net/bonding.c does not even need limits.h.
>
>How UTTERLY braindamaged... I guess we could provide a (dummy?) 
><limits.h> for the kernel environment.  I would definitely like to see 
>the standard compiler-related headers like <stdint.h> as well...

We already have include/linux/limits.h that is included by filesystem
code.  If anybody needs additional #defines, they can go in our version
of limits.h instead of trying to use the gcc version.

