Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264311AbUD0Tjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbUD0Tjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbUD0Tjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:39:31 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:2945 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S264311AbUD0TjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:39:25 -0400
Date: Tue, 27 Apr 2004 20:37:46 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: Steve Lee <steve@tuxsoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <000001c42c8a$485cd950$8119fea9@pluto>
Message-ID: <Pine.LNX.4.44.0404272025460.5186-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Steve Lee wrote:

> Instead of printing module taint messages to the screen, why couldn't
> they just
> be written to syslog?  Then it wouldn't matter if there were several
> taint
> messages.  For example, I know my nVidia driver taints the kernel, I
> don't need
> to see that message over and over again.

Yes, that is exactly what it was a few years ago when I checked (and
probably still is) --- a bug in modutils which needs to be fixed as those
messages are too annoying and aggressive. It should be changed to be made
possible to disable them via /etc/syslog.conf because a normal user
wouldn't have a clue how to disable them otherwise.

Those kind of "kernel messages" should not be seen except when a user
wants to prepare a bug report and send it to linux-kernel. Then he ought
to check dmesg and discover that he is in fact running binary only modules
and also he will discover the support email address and send his report
there instead of here.

Generally, breaking Unix philosophy with such aggressive messages
bypassing standard interfaces is what normally happens in commercial
Unix-es, which are driven by "market requirements" i.e. dictated by people
who have no clue what proper Unix is or should be. So, this part of
modutils is, ironically, very much anti-Linux and "commercial Unix"-like,
although it tries to look precisely opposite. It should be fixed, imho.

I even think that the whole "EXPORT_SYMBOL" vs "EXPORT_SYMBOL_GPL" thing
is moot and anti-freedom because it violates ability of hackers (even if
they happen to work for companies producing binary-only modules, that's
irrelevant) to make proper technical design decisions and instead obey
some person's idea of what is a "good" or "bad" caller of his API. But so
be it, since that's the way Linus and others prefers Linux to be.

Kind regards
Tigran

