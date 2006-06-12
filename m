Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751907AbWFLMWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbWFLMWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWFLMWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:22:53 -0400
Received: from mail.suse.de ([195.135.220.2]:54722 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751907AbWFLMWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:22:52 -0400
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
       hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs time granularity fix for [acm]time going backwards. Also VFS time granularity bug on creat(). (Repost, more content)
References: <20060611115421.GE26475@curie-int.vc.shawcable.net>
From: Andi Kleen <ak@suse.de>
Date: 12 Jun 2006 14:22:50 +0200
In-Reply-To: <20060611115421.GE26475@curie-int.vc.shawcable.net>
Message-ID: <p73ac8isgv9.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> [Please CC me on replies].
> 
> This patch should probably be included for 2.6.17, despite how long the
> bug has been around. It's a one-liner, with no side-effects.

Agreed. Good catch.

That was my bug when doing the conversion - but for my defense
having file systems outside fs/* is error prone.

Can we perhaps move tmpfs or at least the fs parts of shmem.c
into fs/ in the future?  (the file is too big anyways)

-Andi
