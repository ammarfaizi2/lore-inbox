Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267181AbUFZQBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267181AbUFZQBC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267178AbUFZQBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:01:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:224 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267181AbUFZQBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:01:00 -0400
Date: Sat, 26 Jun 2004 09:00:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       george@galis.org
Subject: Re: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
In-Reply-To: <1088262728.2805.7.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0406260855080.14449@ppc970.osdl.org>
References: <1088253429.9831.1449.camel@cube> <1088262728.2805.7.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jun 2004, Arjan van de Ven wrote:
> 
> well.... this value is *passed to userspace* via the AT_ attributes ....
> glibc probably nicely exports this info via sysconf(). I guess/hope your
> tools are now using that ?

Even then, it's a bug in my opinion. Yes, procps should be able to just 
use sysconf(_SC_CLK_TCK), but the fact is, using CLK_TCK and HZ is 
traditional unix behaviour, and we should just support it.

		Linus
