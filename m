Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264114AbTICRQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTICRQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:16:54 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:63115 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264114AbTICRQw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:16:52 -0400
Date: Wed, 3 Sep 2003 18:16:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, hugh@veritas.com, mingo@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030903171623.GA23493@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309021626540.1542-100000@localhost.localdomain> <20030903025605.5C1722C05F@lists.samba.org> <20030903073628.GA19920@mail.jlokier.co.uk> <20030903083451.7fa78c95.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903083451.7fa78c95.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Take mmap_sem for writing around the modification of vma->vm_flags.
> But hold it for reading across the populate function: it does I/O and is
> slow.

Agreed.  Well spotted.

-- Jamie
