Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLaPx0>; Sun, 31 Dec 2000 10:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbQLaPxQ>; Sun, 31 Dec 2000 10:53:16 -0500
Received: from mercury.nildram.co.uk ([195.112.4.37]:34063 "EHLO
	mercury.nildram.co.uk") by vger.kernel.org with ESMTP
	id <S129401AbQLaPxE>; Sun, 31 Dec 2000 10:53:04 -0500
Message-ID: <3A4F4F33.F0EDEA3A@magenta-netlogic.com>
Date: Sun, 31 Dec 2000 15:22:27 +0000
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: J Sloan <jjs@pobox.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tdfx.o and -test13
In-Reply-To: <E14CWw1-0007GV-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Wrong patch. Modversions.h should be getting automatically included. That
> is what needs fixing. You've nicely located the problem and fixed the symptoms
> for the module versioned case
> 
modversions.h is being included in the 'gcc' line, however something is
overriding it
in the case of the agpsupport.c file.  If you move the include
<linux/modversions.h> to
the top of agpsupport.c it also works correctly.

Tony

-- 
Can't think of a decent signature...

tmh@magenta-netlogic.com		http://www.nothing-on.tv
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
