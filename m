Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129034AbQKCNx2>; Fri, 3 Nov 2000 08:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129049AbQKCNxT>; Fri, 3 Nov 2000 08:53:19 -0500
Received: from ha2.rdc2.mi.home.com ([24.2.68.69]:2282 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129034AbQKCNxH>; Fri, 3 Nov 2000 08:53:07 -0500
Message-ID: <3A02C2FD.5A3C9899@didntduck.org>
Date: Fri, 03 Nov 2000 08:51:57 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 boot time check for cpu features
In-Reply-To: <E13rgMG-0003Uc-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > +     lea     cpuid_fail_msg, %si
> > +     call    prtstr
> > +1:   jmp     1b
> > +cpuid_fail_msg:
> > +     .string "Required CPU features are not present - compile kernel for the proper CPU type."
> > +cpuid_pass:
> 
> Only one very minor suggestion
> 
> 1:      hlt
>         j 1b
> 
> Q:      are any of the things you test present in processors only after we
>         do magic 'cpuid' enable invocations ?

AFAIK, none of the braindead chips have cmov instructions or PAE support
(only PentiumPro+ and Athlon do).  If someone can prove me wrong I'd
like to know.

-- 

						Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
