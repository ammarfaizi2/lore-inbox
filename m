Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263374AbRFKD0Q>; Sun, 10 Jun 2001 23:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263375AbRFKD0G>; Sun, 10 Jun 2001 23:26:06 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33246 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263374AbRFKDZw>;
	Sun, 10 Jun 2001 23:25:52 -0400
Message-ID: <3B243A33.8B32FCD6@mandrakesoft.com>
Date: Sun, 10 Jun 2001 23:25:39 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ghofmann@pair.com
Cc: "David S. Miller" <davem@redhat.com>, Russell King <rmk@arm.linux.org.uk>,
        Ben LaHaise <bcrl@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <3B23A4BB.7B4567A3@mandrakesoft.com> <3B23F20A.22574.10AD93@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Glenn C. Hofmann" wrote:
> 
> I have, as was suggested, built as a module, and get unresolved symbol do_softirq, so
> this appears to be another problem in this driver with 2.4.6-pre2.  If I can help in any
> way, please let me know, although I am by no means a programmer, just a tester.

edit kernel/ksyms.c:

-EXPORT_SYMBOL(do_softirq);
+EXPORT_SYMBOL_NOVERS(do_softirq);

and see if that helps.

Errors about do_softirq are unrelated to a specific driver.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
