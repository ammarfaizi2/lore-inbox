Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTFYKQJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 06:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264393AbTFYKQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 06:16:09 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:53776 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S264396AbTFYKQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 06:16:07 -0400
Date: Wed, 25 Jun 2003 12:30:07 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>, <akpm@zip.com.au>,
       <davem@redhat.com>, <linux-kernel@vger.kernel.org>, <mochel@osdl.org>
Subject: Re: [PATCH 3/3] Allow arbitrary number of init funcs in modules 
In-Reply-To: <20030625032450.406202C086@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0306251223390.5042-100000@serv>
References: <20030625032450.406202C086@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 25 Jun 2003, Rusty Russell wrote:

> > What happens if a module is compiled into the kernel and one of the init 
> > functions fails?
> 
> We ignore the failure, as we do with initcalls at the moment.  I
> wasn't really intending to deprecate the existing mechanisms: this is
> simple at least 8)
> 
> Hmm, were you thinking of grouping by KBUILD_BASENAME?  Can you think
> of a case where that would be nicer to use?

It's not a case of nicer to use, it's about consistent behaviour 
independent of how the module is linked into the kernel.
I'm really not convinced this feature is a good idea until the module 
initialization races are not at least basically solved.

bye, Roman

