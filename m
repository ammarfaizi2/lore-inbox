Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932897AbWF0KsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932897AbWF0KsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 06:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933074AbWF0KsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 06:48:15 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62359 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932897AbWF0KsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 06:48:14 -0400
Subject: Re: Calling kernel functions from kprobes/jprobes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: samuelkorpi@myway.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060627080021.453306776E@mprdmxin.myway.com>
References: <20060627080021.453306776E@mprdmxin.myway.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Jun 2006 10:53:28 +0100
Message-Id: <1151402008.32186.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-27 am 04:00 -0400, ysgrifennodd Samuel:
> Hi,
> 
> I am using kprobes/jprobes to try and understand how IP options are
> handled in the kernel. From one of these probes I want to call another
> function inside the kernel, namely ip_options_get_from_user. It is
> defined in net/ipv4/ip_options.c and declared in include/net/ip.h. I
> have included the ip.h header file in my probe, but on compilation I
> get a warning saying the function is undefined. Also, inserting the
> probe fails - "Unknown symbol in module".

Not all symbols are visible or kept. If you want to explore the
internals of the kernel in more depth like this you might find building
user mode linux with debugging enabled and using gdb is both easier and
a lot more fun.

Alan

