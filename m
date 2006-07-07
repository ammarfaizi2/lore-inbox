Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWGGKzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWGGKzA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWGGKzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:55:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8140 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932123AbWGGKy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:54:59 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060706162731.577748e7.akpm@osdl.org> 
References: <20060706162731.577748e7.akpm@osdl.org>  <20060706105223.97b9a531.akpm@osdl.org> <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com> <20060706124727.7098.44363.stgit@warthog.cambridge.redhat.com> <26133.1152211129@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       bernds_cb1@t-online.de, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] FDPIC: Add coredump capability for the ELF-FDPIC binfmt [try #3] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 07 Jul 2006 11:54:48 +0100
Message-ID: <9736.1152269688@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> diff -puN fs/binfmt_elf.c~binfmt_elf-macro-cleanup fs/binfmt_elf.c
> --- a/fs/binfmt_elf.c~binfmt_elf-macro-cleanup
> +++ a/fs/binfmt_elf.c
> ...
> +	if (!dump_seek(roundup((unsigned long)file->f_pos, 4)))
> +		goto err;
> +	if (!dump_write(men->data, men->datasz))
> +		goto err;

That doesn't compile... you're lacking file arguments.

David
