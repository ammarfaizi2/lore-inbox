Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269578AbUJLJhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269578AbUJLJhb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 05:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269581AbUJLJhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 05:37:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:39912 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269578AbUJLJhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 05:37:23 -0400
Date: Tue, 12 Oct 2004 02:35:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1: swsusp not freeing memory on AMD64
Message-Id: <20041012023527.47ae5cf6.akpm@osdl.org>
In-Reply-To: <20041012085748.GD2292@elf.ucw.cz>
References: <200410112349.40551.rjw@sisk.pl>
	<20041012085748.GD2292@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> > It seems that on 2.6.9-rc4-mm1 swsusp is unable to free memory on my AMD64 
>  > box:
>  > 
>  > Stopping tasks: 
>  > ========================================================================|
>  > Freeing memory...  done (0 pages freed)
> 
>  Andrew, I'm afraid this one is for you. I call shrink_all_memory() and
>  vm system does not free anything. That looks like VM bug...

yup, there are some half-written patches in there.
