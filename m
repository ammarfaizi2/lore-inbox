Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWHHLWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWHHLWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWHHLWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:22:35 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18101 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964856AbWHHLWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:22:34 -0400
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/3] uml: use -mcmodel=kernel for x86_64
References: <20060806154700.536.32978.stgit@memento.home.lan>
From: Andi Kleen <ak@suse.de>
Date: 08 Aug 2006 13:22:31 +0200
In-Reply-To: <20060806154700.536.32978.stgit@memento.home.lan>
Message-ID: <p733bc7pj48.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> writes:

> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> We have never used this flag and recently one user experienced a complaining
> warning about this (there was a symbol in the positive half of the address space
> IIRC). So fix it.

You can't use kernel cmodel in user space.  It requires running on negative
virtual addresses. I would be surprised if it worked for you.

-Andi
>
