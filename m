Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbVLMJCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbVLMJCd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVLMJCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:02:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29613 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932555AbVLMJC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:02:29 -0500
Date: Tue, 13 Dec 2005 09:02:19 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213090219.GA27857@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213075441.GB6765@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 08:54:41AM +0100, Ingo Molnar wrote:
> - i did not touch the 'struct semaphore' namespace, but introduced a
>   'struct compat_semaphore'.

Because it's totally brindead.  Your compat_semaphore is a real semaphore
and your semaphore is a mutex.  So name them as such.

> - i introduced a 'type-sensitive' macro wrapper that switches down() 
>   (and the other APIs) to either to the assembly variant (if the 
>   variable's type is struct compat_semaphore), or switches it to the new 
>   generic mutex (if the type is struct semaphore), at build-time. There 
>   is no runtime overhead due to this build-time-switching.

And this one is probably is a great help to win the obsfucated C contests,
but otherwise just harmfull.

