Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131564AbRCNVf7>; Wed, 14 Mar 2001 16:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131569AbRCNVft>; Wed, 14 Mar 2001 16:35:49 -0500
Received: from waste.org ([209.173.204.2]:37728 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S131564AbRCNVfb>;
	Wed, 14 Mar 2001 16:35:31 -0500
Date: Wed, 14 Mar 2001 15:34:19 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Keith Owens <kaos@ocs.com.au>
cc: <esr@thyrsus.com>, Peter Samuelson <peter@cadcamlab.org>,
        <linux-kernel@vger.kernel.org>, <elenstev@mesatop.com>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: Rename all derived CONFIG variables 
In-Reply-To: <24972.984388704@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.30.0103141527370.4691-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001, Keith Owens wrote:

> On Mon, 12 Mar 2001 03:53:07 -0500,
> "Eric S. Raymond" <esr@thyrsus.com> wrote:
> >But if we're going to push Linus and the kernel crew to switch to
> >CML2, then why invite the political tsuris of trying to get a large
> >patch into 2.4 now?  Maybe I'm missing something here, but this doesn't
> >seem necessary to me.
>
> The derived config variables should be in a separate name space,
> whether config is CML1 or CML2.  This patch does it for CML1.

I don't think this makes sense at all.  The derivation of the config
values is the concern of the configuration system, not the code.
Consider something like CONFIG_CPU_HAS_FEATURE_FOO that might currently be
derived from CONFIG_CPU_BAR but may in the future be made independent. Or
vice-versa.  Your proposed name-change means additional maintenance
headache and gets you nothing that you couldn't get by simply including
whatever script you wrote to deduce the dependencies. Such a script would
at least be able to tell you what a variable was derived from.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

