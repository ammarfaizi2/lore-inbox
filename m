Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268068AbUBRUgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267680AbUBRUgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:36:09 -0500
Received: from node-402418b2.mdw.onnet.us.uu.net ([64.36.24.178]:54001 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S268068AbUBRUfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:35:53 -0500
Date: Wed, 18 Feb 2004 14:33:25 -0600
From: Brandon Low <lostlogic@gentoo.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
Message-ID: <20040218203325.GC449@lostlogicx.com>
References: <20040217232130.61667965.akpm@osdl.org> <40338FE8.60809@tmr.com> <20040218200439.GB449@lostlogicx.com> <20040218122216.62bb9e82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218122216.62bb9e82.akpm@osdl.org>
X-Operating-System: Linux found.lostlogicx.com 2.6.1-mm2
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02/18/04 at 12:22:16 -0800, Andrew Morton wrote:
> Brandon Low <blow@rbsys.com> wrote:
> >
> > I must add my voice here in strong opposition of the removal of
> >  cryptoloop from the 2.6 series of kernels.  This is no longer a
> >  development series kernel, I (and others, I'm sure) have been working on
> >  developing technologies which depend on this functionality and which
> >  would be _very_ annoying to do with DM (liveCD-on-cryptoloop-on-iso).
> 
> Why is it problematic?
> 
Involves taking up precious CD space with the DM tools and modules...

Besides, this isn't really the point, the point is that the new dmcrypto
is only in -mm and cryptoloop is in both trees, those of us developing
applications based on cryptoloop don't have a mainline kernel to even
start testing dmcrypto against in the 2.6 series, so it is more a
political issue than a technical issue which makes the removal of a
feature like this from the 2.6 series a bad thing...  (In my humble
never contributed to the kernel opinion)

Technically speaking there is no doubt that you are correct to want to
remove cryptoloop... but if people are depending on that support to stay
in a stable kernel and are developing based on it and don't have the
time to learn dm or dmcrypto and redesign whatever may need redesigning
to use it, it strikes me as rude to pull that support.

> >  Please do not drop cryptoloop!
> 
> ho-hum.  Why should we retain crypto capabilities which have widely
> understood vulnerabilities?
> 
> We mainly want to remove the bio remapping stuff from the loop driver
> because it's horrid and deadlocks under heavy memory pressure.  Maybe we
> can leave crytoloop there with big "kindergarten crypto - do not use"
> labels all over it.
> 
DEPRECATED would probably do...

--
Brandon Low
Release Manager
Ribstone Systems
http://www.ribstonesystems.com
