Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbTIZGUh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 02:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbTIZGUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 02:20:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50567 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261958AbTIZGUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 02:20:36 -0400
Date: Thu, 25 Sep 2003 23:07:02 -0700
From: "David S. Miller" <davem@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030925230702.4ef87780.davem@redhat.com>
In-Reply-To: <3F73D9C4.1050201@colorfullife.com>
References: <3F73D9C4.1050201@colorfullife.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Sep 2003 08:16:36 +0200
Manfred Spraul <manfred@colorfullife.com> wrote:

> Is that really the right solution? Add a full-packet copy to every driver?

In the short term, yes it is.

> IMHO the fastest solution would be to copy only the ip & tcp headers, 
> and keep the rest as it is. And preferable in the network core, to avoid 
> having to copy&paste that into every driver.

You're absolutely correct, but implementing this is far from trivial.
There are assumptions all over the place that the protocol data
immediately follows the protocol headers.

If you're willing to do all of the auditing and work, have at it.
:-)
