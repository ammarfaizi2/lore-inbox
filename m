Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbWALORN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWALORN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWALORN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:17:13 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:56679 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1030406AbWALORM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:17:12 -0500
Date: Thu, 12 Jan 2006 09:16:54 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-reply-to: <Pine.LNX.4.61.0601121437310.11765@scrub.home>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <1137075415.4254.36.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL003ZI97GCY@a34-mta01.direcway.com>
 <200601090109.06051.zippel@linux-m68k.org> <1136779153.1043.26.camel@grayson>
 <200601091232.56348.zippel@linux-m68k.org> <1136814126.1043.36.camel@grayson>
 <Pine.LNX.4.61.0601120019430.30994@scrub.home>
 <1137031253.9643.38.camel@grayson>
 <Pine.LNX.4.61.0601121155450.30994@scrub.home>
 <1137068880.4254.8.camel@grayson>
 <Pine.LNX.4.61.0601121342200.11765@scrub.home>
 <1137072715.4254.24.camel@grayson>
 <Pine.LNX.4.61.0601121437310.11765@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 15:00 +0100, Roman Zippel wrote:
> > My point is that you are making oldconfig and silentoldconfig operate
> > differently when they encounter a closed stdin. You are making them
> > inconsistent. And so far, you have yet to give a valid reason to do so.
> > I've been giving very valid reasons why they should work the same, and
> > why the behavior is correct for them to work that way.
> 
> Even if they sound similiar they are not the same. e.g. I'm working on 
> patches to integrate split config step, so it will do a bit more than 
> normal config targets (but it remain a valid make target). The 
> silentoldconfig target is an automatic target which is also used by kbuild 
> to verify the config consistency.
> The situation is very simple, we have automatic config targets (like 
> silentoldconfig or all*config) and we have interactive config targets 
> (like config, xconfig, oldconfig).
> I'm very much interested to improve the situation of the automatic 
> targets to help automatic builds, but just printing useless information 
> adds no value. If you don't trust that silentoldconfig does the right 
> thing, you can't trust oldconfig either.

What I don't understand is that if oldconfig is an interactive target,
why make it work when interactivity is not available? Also, if
silentoldconfig is an automated target, why make it abort when
interactivity is not available?

Just seems backwards.

For me, silentoldconfig could work, but I prefer the verbosity of
oldconfig. It's just more convenient. It's not that things are checked
in minute detail, but that our builds may eventually disappear (by
upgraded packages), but our build logs remain. It's the only way we have
to go back and check regressions in the build process (it has saved us
many times).

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

