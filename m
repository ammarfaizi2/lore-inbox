Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTGCOcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 10:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbTGCOcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 10:32:05 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:31241 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263752AbTGCOb5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 10:31:57 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch] Hardly triggered tests in bootmem.c ...
Date: Thu, 3 Jul 2003 16:46:07 +0200
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.55.0307021503490.4840@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0307021503490.4840@bigblue.dev.mcafeelabs.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307031646.18127.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 03 July 2003 00:07, Davide Libenzi wrote:
> I was looking at the bootmem.c source and I found those hardly triggered
> tests (unsigned long's).
> (Andrew, sending the patch insted of the note)
>
>
> - Davide
>
>
>
>
> --- linux-2.5.73/mm/bootmem.c.orig	2003-07-02 14:55:47.000000000 -0700
> +++ linux-2.5.73/mm/bootmem.c	2003-07-02 14:56:51.000000000 -0700
> @@ -84,10 +84,6 @@
>
>  	if (!size) BUG();
>
> -	if (sidx < 0)
> -		BUG();
> -	if (eidx < 0)
> -		BUG();
>  	if (sidx >= eidx)
>  		BUG();
>  	if ((addr >> PAGE_SHIFT) >= bdata->node_low_pfn)

shouldn't we convert the remaining
	if (x)
		BUG();

to
	BUG_ON(x)

?

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 16:44:38 up  1:00,  1 user,  load average: 1.00, 1.00, 0.95

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/BEG6oxoigfggmSgRAuFAAJ4iJfEdI5J+SBrDQ9CZM3eEwDC6iwCcDyL7
ssuTGbtylaaqagOLLtYi3ds=
=4xv5
-----END PGP SIGNATURE-----

