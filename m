Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLaXIB>; Sun, 31 Dec 2000 18:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLaXHw>; Sun, 31 Dec 2000 18:07:52 -0500
Received: from mercury.nildram.co.uk ([195.112.4.37]:22539 "EHLO
	mercury.nildram.co.uk") by vger.kernel.org with ESMTP
	id <S129383AbQLaXHk>; Sun, 31 Dec 2000 18:07:40 -0500
Message-ID: <3A4FB514.67F0EA39@magenta-netlogic.com>
Date: Sun, 31 Dec 2000 22:37:08 +0000
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, J Sloan <jjs@pobox.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tdfx.o and -test13
In-Reply-To: <E14CWw1-0007GV-00@the-village.bc.nu> <3A4F4F33.F0EDEA3A@magenta-netlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Hoyle wrote:
> modversions.h is being included in the 'gcc' line, however something is
> overriding it
> in the case of the agpsupport.c file.  If you move the include
> <linux/modversions.h> to
> the top of agpsupport.c it also works correctly.

OK ignore the above.... putting it in agpsupport doesn't fix it.

My kernel tree went a bit T-zone after I did that.  Even removing the
fix totally generated
a completely working module!  I had to 'make distclean' to restore the
old (buggy) behaviour.

Possibly something in the auto-dependencies?  Unfortunately I don't have
the info files for gcc so
I can't work out why the '-include' directive would be
overridden/ignored.

Tony

-- 
Can't think of a decent signature...

tmh@magenta-netlogic.com		http://www.nothing-on.tv
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
