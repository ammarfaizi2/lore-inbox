Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVAKEAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVAKEAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 23:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVAKD7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:59:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:56997 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262486AbVAKD51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:57:27 -0500
Date: Mon, 10 Jan 2005 19:57:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2: panic when munmap()ping the stack
Message-Id: <20050110195710.439aae68.akpm@osdl.org>
In-Reply-To: <1105401719.4153.2.camel@localhost>
References: <1105401719.4153.2.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
> This program causes an instant panic for me:
> 
>          #include <sys/mman.h>
>          
>          int main(int argc, char **argv)
>          {
>          	munmap((char *)(((unsigned long)&argc) & ~4095), 4096*2);
>          
>          	return 0;
>          }

I dont' seem to be able to get it to do anything bad at all, with current
-linus or with the current -mm lineup.  Can you retest -mm3 when it's
cooked?
