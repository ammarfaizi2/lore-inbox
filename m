Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUCIAMO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 19:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUCIAMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 19:12:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:54216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261417AbUCIAMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 19:12:10 -0500
Date: Mon, 8 Mar 2004 16:14:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix warning about duplicate 'const'
Message-Id: <20040308161410.49127bdf.akpm@osdl.org>
In-Reply-To: <200403090043.21043.thomas.schlichter@web.de>
References: <200403090043.21043.thomas.schlichter@web.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <thomas.schlichter@web.de> wrote:
>
> Hi,
> 
> attached is a patch which fixes following wanings:
> 
> drivers/ide/ide-tape.c: In function `idetape_setup':
> drivers/ide/ide-tape.c:4701: Warnung: duplicate `const'
> drivers/video/matrox/matroxfb_g450.c: In function `g450_compute_bwlevel':
> drivers/video/matrox/matroxfb_g450.c:129: Warnung: duplicate `const'
> drivers/video/matrox/matroxfb_g450.c:130: Warnung: duplicate `const'
> drivers/video/matrox/matroxfb_maven.c: In function `maven_compute_bwlevel':
> drivers/video/matrox/matroxfb_maven.c:347: Warnung: duplicate `const'
> drivers/video/matrox/matroxfb_maven.c:348: Warnung: duplicate `const'
> 
> This is done by removing the 'const' from the temporary variables of the min() 
> and max() macros. For me it seems to have no negative impact, so please 
> consider applying...

I think there was a reason for those consts in kernel.h's min() and max()
macros, but memory fails me.  Linus, do you recall?

