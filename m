Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280961AbRKGUKJ>; Wed, 7 Nov 2001 15:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280956AbRKGUKB>; Wed, 7 Nov 2001 15:10:01 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:32781 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280950AbRKGUJu>; Wed, 7 Nov 2001 15:09:50 -0500
Message-ID: <3BE993CD.32E73DD6@zip.com.au>
Date: Wed, 07 Nov 2001 12:04:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <3BE93E77.6E4E3C95@evision-ventures.com> from "Martin Dalecki" at Nov 07, 2001 03:00:23 PM <E161SuY-000498-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > With the following options enabled we get:
> > -freg-struct-return -mrtd -mregparm=3
> >
> >    text    data     bss     dec     hex filename
> > 1302372  260804  288080 1851256  1c3f78 vmlinux
> >
> > Quite significant difference if you ask me!!!
> 
> 30K is nice have but still a scratch on the surface compared with 500K 8)
> 

It's a lot of L1 though.

If this sort of change breaks the ability to build with
conventional argument passing and no-omit-frame-pointer then
the happy kgdb users of this world will be most aggrieved.

-
