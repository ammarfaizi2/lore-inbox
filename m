Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135898AbRD3UcE>; Mon, 30 Apr 2001 16:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135899AbRD3Ubx>; Mon, 30 Apr 2001 16:31:53 -0400
Received: from eastgate.starhub.net.sg ([203.116.1.189]:16388 "EHLO
	eastgate.starhub.net.sg") by vger.kernel.org with ESMTP
	id <S135898AbRD3Ubg>; Mon, 30 Apr 2001 16:31:36 -0400
Message-ID: <XFMail.010501044118.hosler@lugs.org.sg>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3AED958C.3F9EBE1B@mandrakesoft.com>
Date: Tue, 01 May 2001 04:41:18 +0800 (SGT)
Reply-To: Greg Hosler <hosler@lugs.org.sg>
From: Greg Hosler <hosler@lugs.org.sg>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: RE: PATCH 2.4.4: Via audio fixes
Cc: linux-via@gtf.org, Capricelli Thomas <orzel@kde.org>,
        josh <skulcap@mammoth.org>, Arjan van de Ven <arjanv@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30-Apr-01 Jeff Garzik wrote:
> The attached patch includes fixes to the Via audio driver for which I'm
> interested finding testers.  Testing and a private "it works" (hopefully
>:)) or "it doesn't work, <here> is what breaks for me" would be
> appreciated.
> -- 
> Jeff Garzik      | Game called on account of naked chick
> Building 1024    |
> MandrakeSoft     |

it doesn't work.

configuration: SMP, ac'97, IRQ gets assigned to 18.

problem: interrupts appear to not be firing. Neither PRINTK() in
via_intr_channel() or via_interrupt() ever get called (suggesting that
the interrupt is either not firing, or not connected to the service routine).

I've enabled debug, and have more information in the logs, but the short answer
is "the interrupts aren't firing".

in single processor more, no problem. (but that was always the case).

-Greg
 
+---------------------------------------------------------------------+
"DOS Computers manufactured by companies such as IBM, Compaq, Tandy, and
millions of others are by far the most popular, with about 70 million
machines in use wordwide. Macintosh fans, on the other hand, may note that
cockroaches are far more numerous than humans, and that numbers alone do
not denote a higher life form."       (New York Times, November 26, 1991)
| Greg Hosler                           i-net:  hosler@lugs.org.sg    |
+---------------------------------------------------------------------+
