Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129279AbQJ3JZI>; Mon, 30 Oct 2000 04:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129217AbQJ3JY7>; Mon, 30 Oct 2000 04:24:59 -0500
Received: from smtp1.mail.yahoo.com ([128.11.69.60]:25360 "HELO
	smtp1.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129278AbQJ3JYr>; Mon, 30 Oct 2000 04:24:47 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <39FD3CB6.2F641BBF@yahoo.com>
Date: Mon, 30 Oct 2000 04:17:42 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.17 i486)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: pavel rabel <pavel@web.sajt.cz>, linux-net@vger.kernel.org,
        netdev@oss.sgi.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] NE2000
In-Reply-To: <Pine.LNX.4.21.0010300344130.6792-100000@web.sajt.cz> <39FC83CD.B10BF08D@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> pavel rabel wrote:
> > help. So I removed PCI code from ne.c to have ISA only driver. It
> 
> This change sounds ok to me, if noone else objects.  (I added to the CC
> a bit)  I saw that code, and was thinking about doing the same thing
> myself.  ne2k-pci.c definitely has changes which are not included in
> ne.c, and it seems silly to duplicate ne2000 PCI support.

Actually if you look at the archives (ID 39A3A608.1F984C60@yahoo.com)
you will see that I've stated this will be done for 2.5 a couple of
months ago.  (Which is also why PCI support in ne.c hasn't tracked that
of ne2k-pci.c - I want to avoid encouraging new PCI users of ne.c)

There is no urgency in trying to squeeze a patch like this in the back
door of a 2.4.0 release.  For example, there are people out there now
who are using the ne.c driver to run both ISA and PCI cards in the same 
box without having to use 2 different drivers.  We can wait until 2.5.0
to break their .config file.

[ I've several other 8390 related patches I've been sitting on - trying
to not contribute to the delay of 2.4.0 unless explicitly asked, such
as the 8390.h get_module_symbol deletion.  Other 8390 patches I have 
are a separated Tx timeout for 8390.c, kill off dev->rmem_start/end 
and use ioremap() where required, and replace old check/request_region()
with code that makes use of the newer resource structures. ]

Good to know people are still keeping an eye out for dead code though...

Thanks,
Paul.


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
