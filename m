Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWJTJeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWJTJeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWJTJeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:34:10 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:25082 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750730AbWJTJeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:34:07 -0400
Date: Fri, 20 Oct 2006 11:34:41 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.19-rc2-mm2
Message-ID: <20061020113441.6b740c57@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061020015641.b4ed72e5.akpm@osdl.org>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 01:56:41 -0700,
Andrew Morton <akpm@osdl.org> wrote:

> +tty-preparatory-structures-for-termios-revamp.patch
> +tty-preparatory-structures-for-termios-revamp-strip-fix.patch
> +tty-switch-to-ktermios-and-new-framework.patch
> +tty-switch-to-ktermios-and-new-framework-warning-fix.patch
> +tty-switch-to-ktermios.patch
> +tty-switch-to-ktermios-nozomi-fix.patch
> +tty-switch-to-ktermios-bluetooth-fix.patch
> 
>  tty reworks.

sclp_tty needs to use ktermios as well.

CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/s390/char/sclp_tty.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6-CH.orig/drivers/s390/char/sclp_tty.c
+++ linux-2.6-CH/drivers/s390/char/sclp_tty.c
@@ -60,7 +60,7 @@ static unsigned short int sclp_tty_chars
 
 struct tty_driver *sclp_tty_driver;
 
-extern struct termios  tty_std_termios;
+extern struct ktermios tty_std_termios;
 
 static struct sclp_ioctls sclp_ioctls;
 static struct sclp_ioctls sclp_ioctls_init =


