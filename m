Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbTD1C0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 22:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTD1C0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 22:26:20 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:43408 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263184AbTD1C0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 22:26:19 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 27 Apr 2003 19:38:59 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <Pine.LNX.4.53.0304271831250.8792@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.50.0304271908020.7601-100000@blue1.dev.mcafeelabs.com>
References: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org>
 <Pine.LNX.4.53.0304271831250.8792@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Apr 2003, dean gaudet wrote:

> On Sun, 27 Apr 2003, Mark Grosberg wrote:
>
> > I would think on large, multi-user systems that are spawning processes all
> > day, this might improve performance if the shells on such a system were
> > patched.
>
> more relevant is a large multithreaded (or async model with many
> connections per thread/process) webserver spawning cgi.  otherwise you pay
> the costs of duplicating the mm and even if you use F_CLOEXEC (which has a
> cost-per-connection) you have to pay for scanning the open fds.

This might be the only edge of such new syscall IMO. Processes with
hugh file tables. Not the MM stuff, that is fine with vfork().




- Davide

