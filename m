Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWCULmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWCULmV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWCULmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:42:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52703 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030358AbWCULmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:42:20 -0500
Subject: Re: Makefile problem
From: Arjan van de Ven <arjan@infradead.org>
To: cranium2003 <cranium2003@yahoo.com>
Cc: kernel newbies <kernelnewbies@nl.linux.org>,
       kernerl mail <linux-kernel@vger.kernel.org>
In-Reply-To: <20060321112132.36531.qmail@web38002.mail.mud.yahoo.com>
References: <20060321112132.36531.qmail@web38002.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 12:42:08 +0100
Message-Id: <1142941329.3077.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 03:21 -0800, cranium2003 wrote:
> Hi,
>    I have some Makefile questions
> 1)Why a kernel module in 2.6 kernel cannot be compiled
> with single gcc command? Why it requires Makefile in
> current directory so that i can use Makefile?
> 
> 2) why following command used to compile 2.4 kernel
> module fails on 2.6 kernel
> gcc  -D__KERNEL__ -DMODULE -DLINUX -O2 -Wall
> -Wstrict-prototypes -I/lib/modules/`uname
> -r`/build/include -c -o example.ko example.c

because it's broken and isn't using the same CFLAGS as the kernel is.
Read Documentation/kbuild/*

You *HAVE* to use the same CFLAGS as the rest of the kernel.


