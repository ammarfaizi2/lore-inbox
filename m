Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUJXU0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUJXU0n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 16:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbUJXU0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 16:26:42 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:2835 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261672AbUJXU02
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 16:26:28 -0400
Date: Mon, 25 Oct 2004 00:26:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>, torvalds@osdl.org,
       sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-bk7] Select cpio_list or source directory for initramfs image updates [u]
Message-ID: <20041024222630.GA10963@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Martin Schlemmer <azarah@nosferatu.za.org>, torvalds@osdl.org,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <200410200849.i9K8n5921516@mail.osdl.org> <1098533188.668.9.camel@nosferatu.lan> <20041024030844.18f2fedd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024030844.18f2fedd.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 03:08:44AM -0700, Andrew Morton wrote:
> "Martin Schlemmer [c]" <azarah@nosferatu.za.org> wrote:
 
> hmm.  You have a patch in the email body and two slightly different patches
> as attachments.  All bases covered ;)
> 
> I'll stick
> "select-cpio_list-or-source-directory-for-initramfs-image-v7.patch" into
> -mm but would prefer that this patch come in via Sam's tree please.

Fighting with my backlog..
While being away from Linux for a while my kernel suddenly would not compile.
A make mrproper was needed.
This was no good and I realised that generating asm_offsets.h for i386 did 
not check all dependencies.

My fix involve all architectures and I want that pushed -mm before anything else.
And it get rid of the annoying print "asm_offsets.h is up to date"
I do not want to think what horor it could trigger if we change a constant and asm_offsets.h
was not re-generated when it should.

	Sam
