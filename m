Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTJNXtr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 19:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTJNXtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 19:49:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:25253 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261872AbTJNXtq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 19:49:46 -0400
Date: Tue, 14 Oct 2003 16:49:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Karel =?ISO-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Vortex 3c900 passing driver parameters
Message-Id: <20031014164954.20ac88f6.akpm@osdl.org>
In-Reply-To: <20031014183226.A188@beton.cybernet.src>
References: <20031014183226.A188@beton.cybernet.src>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavý <clock@twibright.com> wrote:
>
> Hello
> 
> How do I do a ether=... (kernel boot-time) equivalent of
> insmod 3c59x.o options=0x201 full_duplex=1 ?
> 

Unfortunately you cannot.  `ether=' is broken for all drivers which use the
new(ish) alloc_etherdev() API.

It is due to ordering problems: the name of the interface is not known at
the time of parsing the setup info and nobody has got down and worked out
how to fix it.  
