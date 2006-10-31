Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422705AbWJaEdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422705AbWJaEdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 23:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422710AbWJaEdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 23:33:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422705AbWJaEdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 23:33:41 -0500
Date: Mon, 30 Oct 2006 20:33:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arnaldo Carvalho de Melo <acme@mandriva.com>
Cc: linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: Re: [ANNOUNCE] pahole and other DWARF2 utilities
Message-Id: <20061030203334.09caa368.akpm@osdl.org>
In-Reply-To: <20061030213318.GA5319@mandriva.com>
References: <20061030213318.GA5319@mandriva.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 18:33:19 -0300
Arnaldo Carvalho de Melo <acme@mandriva.com> wrote:

> Hi,
> 
> 	I've been working on some DWARF2 utilities and thought that it
> is about time I announce it to the community, so that what is already
> available can be used by people interested in reducing structure sizes
> and otherwise taking advantage of the information available in the elf
> sections of files compiled with 'gcc -g' or in the case of the kernel
> with CONFIG_DEBUG_INFO enabled, so here it goes the description of said
> tools:
> 
> pahole: Poke-a-Hole is a tool to find out holes in structures, holes
> being defined as the space between members of functions due to alignemnt
> rules that could be used for new struct entries or to reorganize
> existing structures to reduce its size, without more ado lets see what
> that means:
> 
> ...
>
> 	Further ideas on how to use the DWARF2 information include tools
> that will show where inlines are being used, how much code is added by
> inline functions,

It would be quite useful to be able to identify inlined functions which are
good candidates for uninlining.

