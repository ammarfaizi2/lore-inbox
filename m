Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311211AbSCSN2i>; Tue, 19 Mar 2002 08:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311209AbSCSN2a>; Tue, 19 Mar 2002 08:28:30 -0500
Received: from boden.synopsys.com ([204.176.20.19]:61572 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S311203AbSCSN2S>; Tue, 19 Mar 2002 08:28:18 -0500
Date: Tue, 19 Mar 2002 14:27:59 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Jim Hollenback <jholly@cup.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: readv() return and errno
Message-ID: <20020319142759.A1350@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Jim Hollenback <jholly@cup.hp.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1020315135426.ZM923@fry.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Mar 15, 2002 at 01:54:26PM -0800, Jim Hollenback wrote:
>  In doing some testing on the project I'm working on I came
>  across something that is causing a bit of confusion on my part.
> 
>  According to readv(2) EINVAL is returned for an invalid
>  argument.  The examples given were count might be greater than
>  MAX_IOVEC or zero. The test case I am working with has count = 0
>  and I get return of 0 and errno 0 instead of the expected -1
>  and errno EINVAL.
> 
>  Am I missing something?

http://www.opengroup.org/onlinepubs/007904975/
"The Open Group Base Specifications Issue 6", IEEE Std 1003.1-2001:

 The readv() function may fail if:

 [EINVAL]
 The iovcnt argument was less than or equal to 0, or greater than {IOV_MAX}.

Notice the "may"? From the same document:

 may

 Describes a feature or behavior that is optional for an implementation
 that conforms to IEEE Std 1003.1-2001. An application should not rely on
 the existence of the feature or behavior. An application that relies on
 such a feature or behavior cannot be assured to be portable across
 conforming implementations.

 To avoid ambiguity, the opposite of may is expressed as need not,
 instead of may not.
    
So the 0 there just mean nothing, exactly what you get.
 
-alex
