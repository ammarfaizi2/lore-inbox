Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbTHaPas (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTHaPas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:30:48 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:13245 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262122AbTHaPar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:30:47 -0400
Subject: Re: Andrea VM changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Mike Fedyk <mfedyk@matchmail.com>, Antonio Vargas <wind@cocodriloo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
In-Reply-To: <20030831145932.GU24409@dualathlon.random>
References: <Pine.LNX.4.55L.0308301248380.31588@freak.distro.conectiva>
	 <Pine.LNX.4.55L.0308301607540.31588@freak.distro.conectiva>
	 <Pine.LNX.4.55L.0308301618500.31588@freak.distro.conectiva>
	 <20030830231904.GL24409@dualathlon.random>
	 <1062339003.10208.1.camel@dhcp23.swansea.linux.org.uk>
	 <20030831145932.GU24409@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062343789.10208.9.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 16:29:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-31 at 15:59, Andrea Arcangeli wrote:
> And I don't see how you can avoid oom killing to ever happen if the apps
> recurse on the stack and growsdown some hundred megs. In such case
> you've to oom kill, since there's no synchronous failure path during the
> stack growsdown walk.

The stack grow fails and you get a signal. Its up to you to have a
language that handles this or in C enjoy the delights of sigaltstack. In
practice the settings are such that this case basically "doesnt happen"
for all normal use.

> I just don't think it solves or hides the other issues, it seems
> completely orthogonal to me, because you can still run oom during stack
> growsdown.

Agreed - and there will always be corner cases, people who don't want
strict overcommit etc. Thats why I said "as well". Its not a replacement
for OOM handling of some form.

