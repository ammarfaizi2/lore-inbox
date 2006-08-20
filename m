Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWHTSCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWHTSCR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWHTSCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:02:17 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23276 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751110AbWHTSCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:02:16 -0400
Subject: Re: [Patch] Signedness issue in drivers/net/3c515.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org, becker@scyld.com, jgarzik@pobox.com
In-Reply-To: <1156009077.18374.1.camel@alice>
References: <1156009077.18374.1.camel@alice>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 19:22:32 +0100
Message-Id: <1156098152.4051.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-08-19 am 19:37 +0200, ysgrifennodd Eric Sesterhenn:
> hi,
> 
> while playing with gcc 4.1 -Wextra warnings, I came across this one:
> 
> drivers/net/3c515.c:1027: warning: comparison of unsigned expression >= 0 is always true
> 
> Since i is unsigned the >= 0 check in the for loop is always true,
> so we might spin there forever unless the if condition triggers.
> Since i is only used in this loop, this patch changes it to
> an integer.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 

Acked-by: Alan Cox <alan@redhat.com>

[And put JG on the Cc:]
