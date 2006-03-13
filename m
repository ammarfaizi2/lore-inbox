Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751751AbWCMTIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWCMTIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWCMTIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:08:41 -0500
Received: from pproxy.gmail.com ([64.233.166.177]:15660 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751751AbWCMTIl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:08:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=VpT9+E28unZK6cAJqUskRMnYASiqLTgQej4Z2uaTqaINhSw3VX+9Gi1OtSIL8UJscG8Vq+Cc2aRLttU4lIOOfeTxlQvj2r3iD5tD2Kzs8NZqkCzPUdsvQzUvdLMU5CY1YveN4wnTBROQXZ0HuvL8Xey/3GFzKmuKaG0t8dxWIqs=
Date: Mon, 13 Mar 2006 20:08:27 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: arjan@infradead.org, jakexblaster@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Which kernel is the best for a small linux system?
Message-Id: <20060313200827.71968d82.diegocg@gmail.com>
In-Reply-To: <20060313182725.GA31211@mars.ravnborg.org>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com>
	<1142237867.3023.8.camel@laptopd505.fenrus.org>
	<20060313182725.GA31211@mars.ravnborg.org>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.12; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 13 Mar 2006 19:27:25 +0100,
Sam Ravnborg <sam@ravnborg.org> escribió:

> Any comments on this:
> http://www.denx.de/wiki/Know/Linux24vs26
> 
> On another denx.de page I found this summary (so you do not have to
> visit the page):
> # slow to build: 2.6 takes 30...40% longer to compile
> # Big memory footprint in flash: the 2.6 compressed kernel image is
> # 30...40% bigger
> # Big memory footprint in RAM: the 2.6 kernel needs 30...40% more RAM;

In one of those analysis (2.6 sandpoint kernel) they didn't disable
CONFIG_KALLSYMS (they disabled it on the tqm860l though), that makes the
kernel way too big and should be disabled by embedded systems, I don't
understand. That one at least should be fixed, 2.4 didn't even feature
kallsyms.

Also, they claim that context switches are "on average 55% slower (range:
10...94%)", which may be very well a ppc-only bug (in x86 at least
system calls got much faster). And syscalls being much slower is why most
of the other microbenchmarks look so bad.

