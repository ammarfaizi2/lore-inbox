Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTFXQrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTFXQrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:47:40 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:50957 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S262165AbTFXQrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:47:35 -0400
Date: Tue, 24 Jun 2003 19:01:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, <akpm@zip.com.au>, <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, <mochel@osdl.org>
Subject: Re: [PATCH 3/3] Allow arbitrary number of init funcs in modules
In-Reply-To: <20030623092028.2B5272C2FC@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0306241851550.11817-100000@serv>
References: <20030623092028.2B5272C2FC@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 23 Jun 2003, Rusty Russell wrote:

> D: One longstanding complaint is that modules can only have one
> D: module_init, and one module_exit (builtin code can have multiple
> D: __initcall however).  This means, for example, that it is not
> D: possible to write a "module_proc_entry(name, readfn)" function
> D: which can be used like so:
> D: 
> D:   module_init(myinitfn);
> D:   module_cleanup(myinitfn);
> D:   module_proc_entry("some/path/foo", read_foo);

What happens if a module is compiled into the kernel and one of the init 
functions fails?

bye, Roman

