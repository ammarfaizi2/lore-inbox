Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129071AbQKFMhw>; Mon, 6 Nov 2000 07:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129430AbQKFMhc>; Mon, 6 Nov 2000 07:37:32 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:65039 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129203AbQKFMhW>;
	Mon, 6 Nov 2000 07:37:22 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Andrew Morton <andrewm@uow.edu.au>, Paul Gortmaker <p_gortmaker@yahoo.com>,
        "David S. Miller" <davem@redhat.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0 
In-Reply-To: Your message of "Mon, 06 Nov 2000 05:05:42 CDT."
             <3A068276.596F8003@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 23:37:16 +1100
Message-ID: <3075.973514236@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000 05:05:42 -0500, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>With the latest patch I've seen, there is no -need- to
>immediately update the drivers.  Once the patch is applied, I can clean
>the drivers while I'm cleaning up request_region and the other stuff.

I prefer a requirement that all net drivers upgrade to the new
interface, otherwise we have odd drivers using the old interface
forever and being at risk of module unload.  That is why I coded my
patch as returning -ENODEV if there was no dev->open.  However I have
to accept that just before a 2.4 release is not the best time to have a
flag day.  Put it down for 2.5.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
