Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVFVBeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVFVBeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVFVBcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:32:54 -0400
Received: from ns2.suse.de ([195.135.220.15]:25986 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262484AbVFVB0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:26:34 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: reiser@namesys.com, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>
	<42B831B4.9020603@pobox.com.suse.lists.linux.kernel>
	<42B87318.80607@namesys.com.suse.lists.linux.kernel>
	<20050621202448.GB30182@infradead.org.suse.lists.linux.kernel>
	<42B8B9EE.7020002@namesys.com.suse.lists.linux.kernel>
	<42B8BB5E.8090008@pobox.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 Jun 2005 03:26:26 +0200
In-Reply-To: <42B8BB5E.8090008@pobox.com.suse.lists.linux.kernel>
Message-ID: <p73fyvbb2rh.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First Hans let me remind you that this discussion is not XFS vs
reiser4. Christoph does a lot of reviewing and your child definitely
is in serious need of that to be mergeable. I'm sure Christoph is able
to review inpartially even when he is involved with other FS.

Jeff Garzik <jgarzik@pobox.com> writes:
> 
> You're basically implementing another VFS layer inside of reiser4,
> which is a big layering violation.
> 
> This sort of feature should -not- be done at the low-level filesystem level.
> 
> What happens if people decide plugins are a good idea, and they want
> them in ext3?  We need massive surgery to extract the guts from
> reiser4.

We already kind of have them, there are toolkits to do stackable FS with
the existing VFS.

However I suspect Hans is unwilling to redo his file system in this
point. While it looks quite unnecessary there might be other
areas which deserve more attention. In general all the code
needs review, even if it is not as controversal as the reinvented VFS.

-Andi
