Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965289AbWHOIKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289AbWHOIKi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 04:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbWHOIKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 04:10:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:19870 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965289AbWHOIKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 04:10:37 -0400
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org#
Subject: Re: [RHEL5 PATCH 1/4] Provide fallback full 64-bit divide/modulus ops for gcc
References: <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com>
	<20060814211507.27190.61876.stgit@warthog.cambridge.redhat.com>
From: Andi Kleen <ak@suse.de>
Date: 15 Aug 2006 10:10:32 +0200
In-Reply-To: <20060814211507.27190.61876.stgit@warthog.cambridge.redhat.com>
Message-ID: <p734pwea07b.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Provide simple, reasonably quick full 64-bit divide and modulus ops for gcc to
> call behind the scenes as:
> 
> 	__udivmoddi4
> 	__udivdi3
> 	__umoddi3

At least Linus' traditional argument against this is that it's better
to open code these (do_div) so that it's clear to the coder that they
are really costly.

-Andi
