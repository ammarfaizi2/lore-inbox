Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275639AbRIZWMt>; Wed, 26 Sep 2001 18:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275653AbRIZWMk>; Wed, 26 Sep 2001 18:12:40 -0400
Received: from mithra.wirex.com ([65.102.14.2]:15368 "HELO mail.wirex.com")
	by vger.kernel.org with SMTP id <S275639AbRIZWMV>;
	Wed, 26 Sep 2001 18:12:21 -0400
Message-ID: <3BB252BA.9080204@wirex.com>
Date: Wed, 26 Sep 2001 15:12:10 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
In-Reply-To: <E15lfKE-00047d-00@the-village.bc.nu> <3BB10E8E.10008@wirex.com> <20010925202417.A16558@kroah.com> <3BB229D1.10401@wirex.com> <20010926233712.H968@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:

>On Wed, Sep 26, 2001 at 12:17:37PM -0700, Crispin Cowan wrote:
>
>>That is not clear to me. I have been unable to find a definitive 
>>reference that states that is the case.  If so, it is problematic, 
>>because then every user-land program that ever #include'd errno.h from 
>>glibc is GPL'd, because glibc #include's errno.h, among other GPL'd 
>>kernel header files. Are you sure you want to declare nearly all 
>>proprietary Linux applications to be in violation of the GPL?
>>
>AFAIK, the glibc (and most other libraries) are LGPL rather than GPL.
>
It appears that while glibc is LGPL, it in turn #include's stuff from 
the kernel.  It more or less has to; otherwise glibc has to guess the 
format of data structures the kernel is going to export.

Greg is partially correct that this is a licensing issue that the glibc 
maintainers need to resolve. However, I am not convinced that they can 
resolve it on their own. I see only the following possible resolutions:

    * we all decide (an opinion) that #include some_gpl.h does not GPL
      the code doing the including
    * glibc changes its license to GPL, which would make it unpopular
      among proprietary application developers
    * Linux maintainers decide to change the license on the relevant
      header files to LGPL

If one of the above does not happen, then I think I can derive "false" :-)

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX Communications, Inc. http://wirex.com
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html


