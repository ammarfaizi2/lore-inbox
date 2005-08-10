Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbVHJNeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbVHJNeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbVHJNeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:34:23 -0400
Received: from smtp.istop.com ([66.11.167.126]:9637 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S965110AbVHJNeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:34:22 -0400
From: Daniel Phillips <phillips@arcor.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Wed, 10 Aug 2005 23:34:42 +1000
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, hugh@veritas.com
References: <20050808145430.15394c3c.akpm@osdl.org> <200508090724.30962.phillips@arcor.de> <31567.1123679613@warthog.cambridge.redhat.com>
In-Reply-To: <31567.1123679613@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508102334.43662.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 August 2005 23:13, David Howells wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> > > ...kill PG_checked please :)  Or at least keep it from spreading.
> >
> > It already spread - ext3 is using it and I think reiser4.  I thought I
> > had a patch to rename it to PG_misc1 or somesuch, but no.  It's mandate
> > becomes "filesystem-specific page flag".
>
> You're carrying a patch to stick a flag called PG_fs_misc, but that has the
> same value as PG_checked. An extra page flag beyond PG_uptodate, PG_lock
> and PG_writeback is required to make readpage through the cache
> non-synchronous.

David,

Interesting, have you got a pointer to a full explanation?  Is this about aio?

Regards,

Daniel
