Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUEEXGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUEEXGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 19:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbUEEXGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 19:06:52 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7567 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264763AbUEEXGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 19:06:48 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Date: Thu, 6 May 2004 01:04:55 +0200
User-Agent: KMail/1.5.3
References: <200405051312.30626.dominik.karall@gmx.net> <20040505043002.2f787285.akpm@osdl.org> <c7bin8$fg7$1@gatekeeper.tmr.com>
In-Reply-To: <c7bin8$fg7$1@gatekeeper.tmr.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405060104.55340.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 of May 2004 22:31, Bill Davidsen wrote:
> Andrew Morton wrote:
> > Dominik Karall <dominik.karall@gmx.net> wrote:
> >>On Wednesday 05 May 2004 10:31, you wrote:
> >>>+make-4k-stacks-permanent.patch
> >>>
> >>> Fill my inbox.
> >>
> >>Hi Andrew!
> >>
> >>Is there any reason why this patch was applied? Because NVidia users
> >> can't work with the original drivers now without removing this patch
> >> every time.
> >
> > We need to push this issue along quickly.  The single-page stack
> > generally gives us a better kernel and having the stack size configurable
> > creates pain.
>
> Add my voice to those who don't think 4k stacks are a good idea as a
> default, they break some things and seem to leave other paths (as others
> have noted) on the edge. I'm not sure what you have in mind as a "better
> kernel" but I'd rather have a worse kernel and not have to check 4k
> stack as a possible problem before looking at other things if I get bad
> behaviour.
>
> Reliability first, performance later. We've lived with the config for a
> while, pain there is better than pain at runtime.

Opposite opinion here.

If you want 100% reliability you shouldn't use -mm in the first place.

Making 4kb stacks default in -mm is very good idea so it will get necessary
testing and fixing before being integrated into mainline.

Please also note that users of binary only modules always have choice:
- new kernels without binary only modules
- old kernels with binary only modules

It is really that simple.

Regards,
Bartlomiej

