Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWAKHSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWAKHSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 02:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWAKHSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 02:18:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6860 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750728AbWAKHSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 02:18:36 -0500
Date: Tue, 10 Jan 2006 23:18:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why no -mm git tree?
Message-Id: <20060110231818.6164dba7.akpm@osdl.org>
In-Reply-To: <20060111070043.GA7858@localhost.localdomain>
References: <20060111055616.GA5976@localhost.localdomain>
	<20060110224451.44c9d3da.akpm@osdl.org>
	<20060111070043.GA7858@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
>
> On Tue, Jan 10, 2006 at 10:44:51PM -0800, Andrew Morton wrote:
> > Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
> > >
> > > Why don't use a -mm git tree?
> > >
> > 
> > Because everthing would take me 100x longer?
> 
> Really? So does Linus?
> 

Linus does a totally different thing from me.

He reverts about one patch a month.  I drop tens a day.

He never _alters_ patches.  2.6.15-mm1 had about 200 patches which modify
earlier patches and which get rolled up into the patch-which-they-modify
before going upstream.

He never alters the order of patches.

etc.

> > 
> > I'm looking into generating a pullable git tree for each -mm.  Just as a
> > convenience for people who can't type "ftp".
> 
> That doesn't help much if it's only for each -mm.
> If you make git commits for each each patch merged in, then
> we can always run the `current' -mm git tree.

Ah.  If you're suggesting that the -mm git tree have _patches_ under git,
and the way of grabbing the -mm tree is to pull everything and to then
apply all the patches under the patches/ directory then yeah, that would
work.

But my tree at any random point in time is a random piece of
doesn't-even-compile-let-alone-run crap, believe me.  Often not all the
patches even apply.  I don't think there's much point in exposing people to
something like that.

