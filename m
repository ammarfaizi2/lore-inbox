Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTJJEjk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 00:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTJJEjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 00:39:40 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:24715 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262439AbTJJEjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 00:39:39 -0400
Date: Fri, 10 Oct 2003 05:39:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Message-ID: <20031010043932.GA26379@mail.shareable.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAwtz+A6aJAkeufXSGK2GIiwEAAAAA@casabyte.com> <Pine.LNX.4.44.0310071743370.32358-100000@home.osdl.org> <bm48fb$599$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bm48fb$599$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> Your base point that resources shouldn't be shared needlessly is
> correct, or course.

On that theme, non-shared fd tables are slightly faster than shared
due to (a) reduced cache line transfers between CPUs; (b) fewer fds
between tables reduces the time to search for a free fd when something
is opened.

I'm sure it's a tiny effect, but it is there.

-- Jamie
