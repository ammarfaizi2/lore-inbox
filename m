Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267236AbUFZXxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267236AbUFZXxH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUFZXxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:53:07 -0400
Received: from [213.22.183.248] ([213.22.183.248]:6532 "HELO corah.org")
	by vger.kernel.org with SMTP id S267236AbUFZXxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:53:01 -0400
Message-ID: <00cf01c45bd8$b4a23790$020010ac@local>
From: "Joao Santos" <jps@corah.org>
To: <chris@scary.beasts.org>
Cc: <linux-kernel@vger.kernel.org>
References: <007b01c45bd2$9c0687f0$020010ac@local> <Pine.LNX.4.58.0406270032190.24811@sphinx.mythic-beasts.com>
Subject: Re: setuid odd behaviour
Date: Sun, 27 Jun 2004 00:52:57 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2739.300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Chris, my manpages seem to be a bit outdated.

----- Original Message -----
From: <chris@scary.beasts.org>
To: "Joao Santos" <jps@corah.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, June 27, 2004 12:38 AM
Subject: Re: setuid odd behaviour


> Hi,
>
> On Sun, 27 Jun 2004, Joao Santos wrote:
>
> > Hello everyone.
> >
> > I have been rewriting a private privilege system in the 2.6.7 kernel and
> > while making the final tests, vsftpd did not work because it could not
set
> > capabilities after changing to UID 99 (which seemed correct to me).
Just to
> > make sure I was doing the right thing, I booted up a vanilla kernel and
> > traced vsftpd again to see how the kernel was reacting to that setcap()
> > after setuid() and strangely the kernel let the setcap through and
returned
> > success.
>
> Yep - vsftpd uses prctl(PR_SET_KEEPCAPS, 1) to achieve this.
> It's necessary because there's little point in reducing your capability
> set unless you also switch away from uid 0 (it owns files which could be
> used to regain full capabilities).
>
> Cheers
> Chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


