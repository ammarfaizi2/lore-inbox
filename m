Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422728AbWAMRoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbWAMRoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422740AbWAMRoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:44:23 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:64146 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1422728AbWAMRoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:44:23 -0500
Date: Fri, 13 Jan 2006 18:44:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ben Collins <ben.collins@ubuntu.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-Reply-To: <1137075415.4254.36.camel@grayson>
Message-ID: <Pine.LNX.4.61.0601131834590.30994@scrub.home>
References: <0ISL003ZI97GCY@a34-mta01.direcway.com> <200601090109.06051.zippel@linux-m68k.org>
 <1136779153.1043.26.camel@grayson> <200601091232.56348.zippel@linux-m68k.org>
 <1136814126.1043.36.camel@grayson> <Pine.LNX.4.61.0601120019430.30994@scrub.home>
 <1137031253.9643.38.camel@grayson> <Pine.LNX.4.61.0601121155450.30994@scrub.home>
 <1137068880.4254.8.camel@grayson> <Pine.LNX.4.61.0601121342200.11765@scrub.home>
 <1137072715.4254.24.camel@grayson> <Pine.LNX.4.61.0601121437310.11765@scrub.home>
 <1137075415.4254.36.camel@grayson>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 12 Jan 2006, Ben Collins wrote:

> What I don't understand is that if oldconfig is an interactive target,
> why make it work when interactivity is not available?

It means it will accept any input and no input (by just pressing enter or 
ctrl-d) means the default answer.

> Also, if
> silentoldconfig is an automated target, why make it abort when
> interactivity is not available?

It's called during a normal kbuild and must work in any situation.

> For me, silentoldconfig could work, but I prefer the verbosity of
> oldconfig. It's just more convenient. It's not that things are checked
> in minute detail, but that our builds may eventually disappear (by
> upgraded packages), but our build logs remain. It's the only way we have
> to go back and check regressions in the build process (it has saved us
> many times).

The output is unlikely to help you, you'll still have the .config file and 
that is a much better source to verify the configuration step.

bye, Roman
