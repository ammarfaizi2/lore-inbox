Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287183AbRL2LOm>; Sat, 29 Dec 2001 06:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287186AbRL2LOc>; Sat, 29 Dec 2001 06:14:32 -0500
Received: from [64.42.30.110] ([64.42.30.110]:4100 "HELO mail.clouddancer.com")
	by vger.kernel.org with SMTP id <S287183AbRL2LOT>;
	Sat, 29 Dec 2001 06:14:19 -0500
To: linux-kernel@vger.kernel.org
Message-Id: <20011229111337.15E827843A@phoenix.clouddancer.com>
Date: Sat, 29 Dec 2001 03:13:37 -0800 (PST)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colonel <klink@clouddancer.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 has broken RTNETLINK
Reply-to: klink@clouddancer.com


Previously.....
On Tue, Dec 25, 2001 at 05:17:01PM +0100, Manfred Spraul wrote:
> > When I went to build 2.4.17 on a dinky box (486, 16M RAM), the
> > config option was missing.  The box is a wall mount and is not very
> > capable of multiple kernel experimentation alas.  Can someone
> > supply some background as to what has happened?
>
> It seems that RTNETLINK is now unconditionally enabled, I don't know
> why.
It's required by newer RedHat and MDK initscripts, perhaps others.
ip, iproute and similar utilities use it, and so since it's commonly
required DaveM made it unconditional...  I think the checkin comment was
something along the lines of "make it unconditional unless Alan
complains about kernel bloat" :)
        Jeff
..................................................................

So I went ahead, built 2.4.17, and BIRD doesn't work.  Dropped back to
2.4.16, enabled the RTNETLINK option and all is fine.  Something is
amiss here.

r

