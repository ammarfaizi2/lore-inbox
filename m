Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbTIEOp6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTIEOp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:45:58 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1408 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263076AbTIEOoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:44:44 -0400
Date: Fri, 5 Sep 2003 15:57:57 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309051457.h85EvvPJ000124@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, ndiamond@wta.att.ne.jp
Subject: Re: keyboard - was: Re: Linux 2.6.0-test4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > At this late stage, I don't think it is a good idea to completely
> > rewrite the untranslate algorithm.  So we continue to hack it and hack
> > it until it works.  :-/
>
> Surely not.  Some keyboards which worked since 2.0 and probably 1.something
> are broken in 2.6.

Aren't we over-complicating this?

The vast majority of keyboards are usable with translated Set 2, and
no workarounds.  Some workarounds may break other keyboards, possibly
ones we don't even know about yet.

There are advantages to using untranslated Set 2, and Set 3, and some
keyboards need to be used in those modes them to work correctly.

So, why not:

* Default to translated Set 2 with no work arounds, unless the
keyboard is known to work fine in Set 3.

Either:

1. It works perfectly.
2. It doesn't.

In case 1, if the user is happy with translated Set 2, there is no
problem.  If they are interested in seeing whether the technically
neater untranslated Set 2, or Set 3 work for them they can test them
and see.

In case 2, the user can boot with a kernel parameter enabling
workarounds for broken keyboards.  Conflicting workarounds can be
moved in to different sets, I.E. boot with inputworkarounds=1 for the
most common ones, and inputworkarounds=2 for the less common ones.

This should get almost all keyboards working by default.  Most of
those that don't work due to critical errors such as keys bouncing and
excessive auto-repeat, and those that don't work fully, should work
fully with workarounds enabled.

My keyboard which requires Set 3 to operate fully sends a distinctive
ID, so can be identified, and set to Set 3 automatically.

John.
