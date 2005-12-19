Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVLSPB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVLSPB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVLSPB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:01:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54672 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932150AbVLSPB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:01:29 -0500
Date: Mon, 19 Dec 2005 15:01:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 15/15] Generic Mutex Subsystem, arch-semaphores.patch
Message-ID: <20051219150127.GB9809@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@ftp.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
References: <20051219014043.GK28038@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219014043.GK28038@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 02:40:43AM +0100, Ingo Molnar wrote:
> 
> mark all semaphores that are known to be used in a non-mutex fashion, as 
> arch_semaphores. This has relevance for the CONFIG_DEBUG_MUTEX_FULL 
> debugging kernel: these semaphores will never be changed to mutexes, not 
> even for debugging purposes.

NACK.  Just keep these as struct semaphore.  Maybe one day we can do a simple
machine-independ semaphore implementation for the few cases remaining, but
this renaming is just rather silly.

