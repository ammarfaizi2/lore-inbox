Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTLXOxY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 09:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTLXOxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 09:53:23 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:9676 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S263625AbTLXOxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 09:53:20 -0500
Date: Wed, 24 Dec 2003 15:38:58 +0100
From: GCS <gcs@lsc.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-mm1
Message-ID: <20031224143858.GA14113@lsc.hu>
References: <20031224095921.GA8147@lsc.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20031224095921.GA8147@lsc.hu>
User-Agent: Mutt/1.3.28i
X-Operating-System: GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 10:59:21AM +0100, GCS <gcs@lsc.hu> wrote:
> [...] but still some lock or sth
> is not unlocked, as the CPU is used more and more about five secs by one
> or two percent. Sooner or later it's crashed as well, but I could
> restart the machine before that happened.
 Update: I could trigger this bug in 2.6.0-mm1 as well with the Linux
port of Head over Heels (classic game from C64). The CPU was getting
more and more used, so the game slowed down. I could quit then from the
game and XFree86. I did an emergency sync, and it succeded. Issued halt,
but it stopped at init sending term to all processes, so I tried a hard
power off. I got an error, something about slab, maybe at line 168. It
was scrolled out too fast by the stack-trace, and at the end:
ACPI-0094: *** Error: Could not acquire interpreter mutex
Crashed there. :-(

GCS
