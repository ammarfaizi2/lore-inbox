Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVBVV2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVBVV2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVBVV2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:28:13 -0500
Received: from mail.shareable.org ([81.29.64.88]:19112 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261263AbVBVV2C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:28:02 -0500
Date: Tue, 22 Feb 2005 21:27:45 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Andrew Morton <akpm@osdl.org>, Olof Johansson <olof@austin.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050222212745.GI22555@mail.shareable.org>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> <421BA1FD.8030108@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421BA1FD.8030108@nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> >	down_read(&current->mm->mmap_sem);
> >	get_futex_key(...) etc.
> >	queue_me(...) etc.
> >	current->flags |= PF_MMAP_SEM;             <- new
> >	ret = get_user(...);
> >	current->flags &= PF_MMAP_SEM;             <- new
> >	/* the rest */
> 
> Should the second new line be this (with the inverse)?
> 
> 	current->flags &= ~PF_MMAP_SEM;

Quiet!  I was trying to sneak in a security hole! :)

-- Jamie
