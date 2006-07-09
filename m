Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWGIVg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWGIVg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWGIVg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:36:29 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:12486 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932382AbWGIVg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:36:28 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Sun, 9 Jul 2006 23:36:43 +0200
User-Agent: KMail/1.9.3
Cc: Bojan Smojver <bojan@rexursive.com>, Pavel Machek <pavel@ucw.cz>,
       Arjan van de Ven <arjan@infradead.org>, Sunil Kumar <devsku@gmail.com>,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>
References: <20060627133321.GB3019@elf.ucw.cz> <200607091551.18456.rjw@sisk.pl> <200607100706.45789.ncunningham@linuxmail.org>
In-Reply-To: <200607100706.45789.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607092336.44208.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 23:06, Nigel Cunningham wrote:
]-- snip --[
> > Now there's the separate problem that we have to share _some_ code.
> > To an absolute minimum, we have to share the freezer code and the
> > code that handles devices, because it's also shared by suspend-to-RAM.
> > The code that handles devices is already shared, but we also _have_ _to_
> > share the freezer code.  Therefore, as long as suspend2 adds some code
> > to the freezer, it's not even close to be considerable for merging.
> 
> If Suspend2 added code in a way that broke swsusp, I would agree. But it 
> doesn't.

This is not a matter of any breakage or lack thereof.  The problem is that the
freezer is _not_ _an_ _swsusp-only_ _code_.  It is used by someone else too,
and having two different freezers in the tree would be _insane_, because too
many things depend on that.  This would be like having two different memory
management systems, but at a smaller scale.

As far as I'm concerned, we _must_ find a way to have _one_ common freezer,
before we can _think_ of anything more.  Still that's not even complicated,
because your freezer changes are quite well separeted, so please resubmit
them and we'll discuss them again.  Perhaps we'll be able to reach an
agreement on what's mergeable and what's not and why.  Then, I'll do my
best to get the mergeable stuff merged, and when it gets merged, you will
drop the non-mergeable freezer changes.  I hope this is fair enough.

Rafael
