Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTI0D6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 23:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTI0D6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 23:58:41 -0400
Received: from rth.ninka.net ([216.101.162.244]:43186 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262072AbTI0D6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 23:58:40 -0400
Date: Fri, 26 Sep 2003 20:57:33 -0700
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030926205733.7942a74e.davem@redhat.com>
In-Reply-To: <16244.31648.766419.56901@napali.hpl.hp.com>
References: <A2yd.64p.31@gated-at.bofh.it>
	<A2yd.64p.29@gated-at.bofh.it>
	<A317.6GH.7@gated-at.bofh.it>
	<m37k3viiqp.fsf@averell.firstfloor.org>
	<16244.31648.766419.56901@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Sep 2003 10:47:12 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> Arches that don't like/support unaligned accesses will certainly
> have a copy_user() which handles misalignment just fine.  For
> example, on ia64, the copy will run slightly slower because of an
> additional shift in the loop, but that penalty only shows on fully
> cached data.

Exactly correct, and on many platforms (sparc64 happens to be one)
there is _ZERO_ performance penalty for misalignment or source or
destination buffer during a memcpy/memmove.
