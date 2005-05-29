Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVE2VQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVE2VQt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 17:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVE2VQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 17:16:49 -0400
Received: from stark.xeocode.com ([216.58.44.227]:20689 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261444AbVE2VQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 17:16:46 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] prevent NULL mmap in topdown model
References: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com>
	<Pine.LNX.4.58.0505181535210.18337@ppc970.osdl.org>
	<Pine.LNX.4.61.0505182224250.29123@chimarrao.boston.redhat.com>
	<Pine.LNX.4.58.0505181946300.2322@ppc970.osdl.org>
	<20050519064657.GH23013@shell0.pdx.osdl.net>
	<1116490511.6027.25.camel@laptopd505.fenrus.org>
In-Reply-To: <1116490511.6027.25.camel@laptopd505.fenrus.org>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 29 May 2005 17:16:33 -0400
Message-ID: <87u0klybpq.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Wed, 2005-05-18 at 23:46 -0700, Chris Wright wrote:
>
> sure. Making it *impossible* to mmap that page is bad. People should be
> able to do that if they really want to, just doing it if they don't ask
> for it is bad.
> 
> There are plenty of reasons people may want that page mmaped, one of
> them being that the compiler can then do more speculative loads around
> null pointer checks. Not saying it's a brilliant idea always, but making
> such things impossible makes no sense.

More realistically, iirc either Wine or dosemu, i forget which, actually has
to map page 0 to work properly.

-- 
greg

