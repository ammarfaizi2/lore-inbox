Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129246AbQKFNTR>; Mon, 6 Nov 2000 08:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbQKFNTI>; Mon, 6 Nov 2000 08:19:08 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:14608 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129246AbQKFNS5>;
	Mon, 6 Nov 2000 08:18:57 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Andrew Morton <andrewm@uow.edu.au>, Paul Gortmaker <p_gortmaker@yahoo.com>,
        "David S. Miller" <davem@redhat.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0 
In-Reply-To: Your message of "Mon, 06 Nov 2000 08:09:28 CDT."
             <3A06AD88.15640B7D@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Nov 2000 00:18:50 +1100
Message-ID: <3848.973516730@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000 08:09:28 -0500, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>You are missing the point here.  If a driver is "old style", where
>owner==NULL and it manually calls MOD_{INC,DEC}_USE_COUNT, things are
>pretty much ok.  There is a tiny race, but the system is mostly intact.

Small race * size of install base * auto unload frequency => too many
bug reports for my liking.  But we agree that requiring dev->open is
2.5 material.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
