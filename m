Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUJAWS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUJAWS6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUJAWQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:16:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:32237 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266704AbUJAWOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 18:14:02 -0400
Date: Fri, 1 Oct 2004 15:17:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc -align options .config-settable
Message-Id: <20041001151751.3917d9d5.akpm@osdl.org>
In-Reply-To: <200410012226.23565.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200410012226.23565.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
>
> With all alignment options set to 1 (minimum alignment),
> I've got 5% smaller vmlinux compared to one built with
> default code alignment.
> 

Sam, can you process this one?

> 
>  
> +GCC_VERSION	= $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))

It bugs me that we're evaluating the same thing down in arch/i386/Makefile.
 Perhaps we should evaluate GCC_VERSION once only, as some top-level kbuild
thing.  So everyone can assume that it's present and correct?
