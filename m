Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946094AbWJTNQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946094AbWJTNQz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946127AbWJTNQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:16:55 -0400
Received: from [81.2.110.250] ([81.2.110.250]:10704 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1946094AbWJTNQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:16:54 -0400
Subject: Re: 2.6.19-rc2-mm2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
In-Reply-To: <20061020113441.6b740c57@gondolin.boeblingen.de.ibm.com>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
	 <20061020113441.6b740c57@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Oct 2006 14:19:29 +0100
Message-Id: <1161350370.26440.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-20 am 11:34 +0200, ysgrifennodd Cornelia Huck:
> --- linux-2.6-CH.orig/drivers/s390/char/sclp_tty.c
> +++ linux-2.6-CH/drivers/s390/char/sclp_tty.c
> @@ -60,7 +60,7 @@ static unsigned short int sclp_tty_chars
>  
>  struct tty_driver *sclp_tty_driver;
>  
> -extern struct termios  tty_std_termios;
> +extern struct ktermios tty_std_termios;
>  

tty_std_termios is defined in the header files, and has been since
before the S/390 port existed. This line should be unncesssary as its
defined in tty.h

Alan

