Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272286AbTHIIwL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 04:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272287AbTHIIwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 04:52:11 -0400
Received: from rth.ninka.net ([216.101.162.244]:50908 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S272286AbTHIIwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 04:52:10 -0400
Date: Sat, 9 Aug 2003 01:51:42 -0700
From: "David S. Miller" <davem@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: jamie@shareable.org, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org, chip@pobox.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-Id: <20030809015142.56190015.davem@redhat.com>
In-Reply-To: <20030809081346.GC29616@alpha.home.local>
References: <1060087479.796.50.camel@cube>
	<20030809002117.GB26375@mail.jlokier.co.uk>
	<20030809081346.GC29616@alpha.home.local>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003 10:13:46 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> (how could !!x be 0 if x isn't ?)

I believe the C language allows for systems where the NULL pointer is
not zero.

I can't think of any reason why the NULL macro exists otherwise.

However, even if I'm right, I dread the guy who has to make other
people's code work on such a platform.  Using normal boolean tests for
NULL pointer checks is just too common.

