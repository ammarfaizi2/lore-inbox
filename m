Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVCCDyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVCCDyF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVCCDvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 22:51:15 -0500
Received: from mail.autoweb.net ([198.172.237.26]:57356 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261446AbVCCDqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 22:46:30 -0500
Date: Wed, 2 Mar 2005 22:46:28 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303034627.GF7828@mythryan2.michonline.com>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 02:21:38PM -0800, Linus Torvalds wrote:
> The problem with major development trees like 2.4.x vs 2.5.x was that the 
> release cycles were too long, and that people hated the back- and 
> forward-porting. That said, it did serve a purpose - people kind of knew 
> where they stood, even though we always ended up having to have big 
> changes in the stable tree too, just to keep up with a changing landscape.

How about this idea, instead:

At 2.6.12, make two parallel BitKeeper trees:

2.6 and 2.7

Push bugfixes into 2.6.

Push *everything* that's not a bugfix into 2.7.
"bk pull" the 2.6 tree into the 2.7 tree each day when you wake up.

A week later, release 2.6.12.1 from the 2.6 tree, then immediately bk
pull the 2.7 tree into the 2.6 tree.

Release 2.6.13-rc1 at about the same time, and again only take bugfixes
into the 2.6 tree.

In 3-7 weeks, after a few more -rc iterations with just bugfixes,
release 2.6.13.

This should keep the differences between the trees down to something
somewhat... sane, and, hopefully, keep the stable tree stable.

People working on big changes can do them against 2.6.x if they need
stability, and know that if they stay current with each 2.6.x release as
they work, they should have a controllable amount of pain for merges.

My thinking is simply that if you're going to use BitKeeper, you might
as well abuse it for all that it's worth.

-- 

Ryan Anderson
  sometimes Pug Majere
