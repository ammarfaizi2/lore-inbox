Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbVAKXFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbVAKXFS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbVAKXFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:05:17 -0500
Received: from gw.c9x.org ([213.41.131.17]:55919 "HELO
	nerim.mx.42-networks.com") by vger.kernel.org with SMTP
	id S262927AbVAKXEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:04:04 -0500
Date: Wed, 12 Jan 2005 00:03:40 +0059
From: "Frank Denis \(Jedi/Sector One\)" <lkml@pureftpd.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2: panic when munmap()ping the stack
Message-ID: <20050111230402.GA5839@c9x.org>
References: <1105401719.4153.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105401719.4153.2.camel@localhost>
X-Operating-System: OpenBSD - http://www.openbsd.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 04:01:58PM -0800, Jeremy Fitzhardinge wrote:
> This program causes an instant panic for me:
>         #include <sys/mman.h>
>         int main(int argc, char **argv)
>         {
>         	munmap((char *)(((unsigned long)&argc) & ~4095), 4096*2);
>         	return 0;
>         }
> Plain 2.6.10 segfaults as expected; I haven't tried -mm1 to see what it
> does.

  I get an instant reboot with 2.6.10-mm2 and 2.6.10-mm1 with one page.
  
  2.6.10-rc3-mm1 just segfaults as expected.

--
Frank - my stupid blog: http://00f.net
