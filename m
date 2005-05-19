Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVESIYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVESIYE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 04:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVESIYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 04:24:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:31926 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262451AbVESIYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 04:24:01 -0400
Date: Thu, 19 May 2005 01:23:45 -0700
From: Chris Wright <chrisw@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] prevent NULL mmap in topdown model
Message-ID: <20050519082345.GI23013@shell0.pdx.osdl.net>
References: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0505181535210.18337@ppc970.osdl.org> <Pine.LNX.4.61.0505182224250.29123@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0505181946300.2322@ppc970.osdl.org> <20050519064657.GH23013@shell0.pdx.osdl.net> <1116490511.6027.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116490511.6027.25.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjan@infradead.org) wrote:
> On Wed, 2005-05-18 at 23:46 -0700, Chris Wright wrote:
> > I gave it a quick and simple test.  Worked as expected.  Last page got
> > mapped at 0x1000, leaving first page unmapped.  Of course, either with
> > MAP_FIXED or w/out MAP_FIXED but proper hint (like -1) you can still
> > map first page.  This isn't to say I was extra creative in testing.
> 
> sure. Making it *impossible* to mmap that page is bad. People should be
> able to do that if they really want to, just doing it if they don't ask
> for it is bad.

Heh, that was actually my intended point ;-)  At any rate, you made it
clearer, thanks.
