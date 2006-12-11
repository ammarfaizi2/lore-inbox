Return-Path: <linux-kernel-owner+w=401wt.eu-S936934AbWLKQGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936934AbWLKQGJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936935AbWLKQGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:06:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39020 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936934AbWLKQGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:06:07 -0500
Date: Mon, 11 Dec 2006 08:05:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Akinobu Mita <akinobu.mita@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Mark bitrevX() functions as const
In-Reply-To: <29447.1165840536@redhat.com>
Message-ID: <Pine.LNX.4.64.0612110803340.12500@woody.osdl.org>
References: <29447.1165840536@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, David Howells wrote:
> 
> Mark the bit reversal functions as being const as they always return the same
> output for any given input.

Well, we should mark the argument const too, no?

Does anythign actually improve from this? Also, we should actually use 
"__attribute_const__" instead (which works with other compilers), not the 
gcc'ism. That "__attribute__((const))" thing is a horrible syntax anyway 
(and has apparently slipped into <linux/log2.h> too - Damn.

		Linus
