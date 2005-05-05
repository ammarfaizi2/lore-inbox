Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVEEB1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVEEB1l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 21:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVEEB1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 21:27:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58561 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261777AbVEEB1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 21:27:39 -0400
Date: Wed, 4 May 2005 21:27:21 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: William Jordan <bjordan.ics@gmail.com>
cc: Andy Isaacson <adi@hexapodia.org>,
       Caitlin Bestler <caitlin.bestler@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, hch@infradead.org,
       Timur Tabi <timur.tabi@ammasso.com>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
 verbs implementation
In-Reply-To: <78d18e2050504112240e43a08@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0505042123410.18390@chimarrao.boston.redhat.com>
References: <469958e00504291731eb8287c@mail.gmail.com>  <20050503184325.GA19351@hexapodia.org>
 <78d18e2050504112240e43a08@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2005, William Jordan wrote:
> On 5/3/05, Andy Isaacson <adi@hexapodia.org> wrote:
> > Rather than replacing the fully-registered pages with pages of zeros,
> > you could simply unmap them.
> 
> I don't like this option. It is nearly free to map all of the pages to
> the zero-page. You never have to allocate a page if the user never
> writes to it.

Unmapping should work fine, as long as the VMA flags are
set appropriately.  The page fault handler can take care
of the rest...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
