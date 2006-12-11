Return-Path: <linux-kernel-owner+w=401wt.eu-S936413AbWLKQNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936413AbWLKQNe (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936964AbWLKQNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:13:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35168 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936413AbWLKQNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:13:33 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0612110803340.12500@woody.osdl.org> 
References: <Pine.LNX.4.64.0612110803340.12500@woody.osdl.org>  <29447.1165840536@redhat.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Akinobu Mita <akinobu.mita@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Mark bitrevX() functions as const 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 11 Dec 2006 16:12:52 +0000
Message-ID: <29623.1165853572@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> > Mark the bit reversal functions as being const as they always return the
> > same output for any given input.
> 
> Well, we should mark the argument const too, no?

The argument is just an integer; I'm not sure that marking it const actually
achieves anything, except to tell the function that it can't modify it - and
since it's effectively a copy, where's the fun in that.

> Does anythign actually improve from this? Also, we should actually use 
> "__attribute_const__" instead (which works with other compilers), not the 
> gcc'ism. That "__attribute__((const))" thing is a horrible syntax anyway 
> (and has apparently slipped into <linux/log2.h> too - Damn.

Ah.  I thought that was just for supporting old versions of gcc.  I didn't
realise it was for handling strange compilers.

David
