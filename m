Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265749AbUGTJF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265749AbUGTJF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 05:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbUGTJF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 05:05:28 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:11958 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265749AbUGTJFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 05:05:21 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Kurt Garloff <garloff@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Date: Tue, 20 Jul 2004 11:14:48 +0200
User-Agent: KMail/1.5
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de
References: <1089771823.15336.2461.camel@abyss.home> <20040715015431.GF3411@holomorphy.com> <20040718161338.GC12527@tpkurt.garloff.de>
In-Reply-To: <20040718161338.GC12527@tpkurt.garloff.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407201114.48768.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 of July 2004 18:13, Kurt Garloff wrote:
> Hi,
>
> On Wed, Jul 14, 2004 at 06:54:31PM -0700, William Lee Irwin III wrote:
> > On Wed, Jul 14, 2004 at 05:30:52PM -0700, Peter Zaitsev wrote:
> > > Why can't it be moved to other zone if there is a lot of place where ?
> > > In general I was not pushing system in some kind of stress mode - There
> > > was still a lot of cache memory available. Why it could not be instead
> > > shrunk to accommodate allocation ?
> >
> > The only method the kernel now has to relocate userspace memory is IO.
>
> But that could be changed.
> If we can swap out and modify the page tables (to mark the page paged
> out) and page in to some other location (and modify the pagetables
> again), we can as well just copy a page and modify the page tables.

Actually we don't need to swap out any pages for this purpose.  It suffices to 
modify the page tables to indicate that certain pages should be _moved_ to 
some other locations, IM(H)O.

Yours,
rjw

-- 
Rafael J. Wysocki
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
