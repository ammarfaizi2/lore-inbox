Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVCDKye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVCDKye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVCDKwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:52:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:24278 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262633AbVCDKwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:52:09 -0500
Date: Fri, 4 Mar 2005 02:51:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, hugang@soulinfo.com
Subject: Re: swsusp: use non-contiguous memory on resume
Message-Id: <20050304025119.4b3f8aa6.akpm@osdl.org>
In-Reply-To: <20050304102121.GG1345@elf.ucw.cz>
References: <20050304095934.GA1731@elf.ucw.cz>
	<20050304021347.1b3e0122.akpm@osdl.org>
	<20050304102121.GG1345@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Problem is that pagedir is allocated as order-8 allocation on resume
>  in -mmX (and linus). Unfortunately, order-8 allocation sometimes
>  fails, and for some people (Rafael, seife :-) it fails way too often.
> 
>  Solution is to change format of pagedir from table to linklist,
>  avoiding high-order alocation. Unfortunately that means changes to
>  assembly, too, as assembly walks the pagedir.

Ah.

>  (Or maybe Rafael is willing to create -mm version and submit it
>  himself?)

No, against -linus, please.  But the chunk in kernel/power/swsusp.c looks
like it came from a diff between -mm and -linus.  Or something.

