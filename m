Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWENQTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWENQTM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 12:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWENQTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 12:19:12 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:44165 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751488AbWENQTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 12:19:12 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [linux-pm] Re: [PATCH/rfc] schedule /sys/device/.../power for removal
Date: Sun, 14 May 2006 08:51:26 -0700
User-Agent: KMail/1.7.1
Cc: linux-pm@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20060512100544.GA29010@elf.ucw.cz> <200605120652.55658.david-b@pacbell.net> <1147565632.21291.15.camel@localhost.localdomain>
In-Reply-To: <1147565632.21291.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605140851.29221.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 May 2006 5:13 pm, Benjamin Herrenschmidt wrote:
> On Fri, 2006-05-12 at 06:52 -0700, David Brownell wrote:
> > On Friday 12 May 2006 3:11 am, Andrew Morton wrote:
> > > 
> > > What will be impacted by this?
> > 
> > Driver suspend/resume testing ... impact is strongly negative.
> > ...
> > Which IMO makes removing this a Bad Thing.  It needs to have some
> > kind of replacement in place before the "magic numbers" go away.
> 
> And that's why Pavel is not proposing to remove it right away... but to
> schedule it's removal so that developpers know right now that building a
> whole new kernel<->user interface based on that is not the smartest
> thing to do.

How could we schedule the removal before we have even had a couple
releases to fine-tune its replacement, and verify that the main issues
with the current thing are fully resolved?

... plus, removing the whole power/* directory is clearly wrong.  The
issue that's been acknowledged is only with the contents of a single
file, power/state, not the whole directory.

There may be a bit of a gap in the process here.  "July 2007" is a
date that's not backed up by anything more than agreement that the
current approach is a lose.  Deprecation is not the same as removal.


