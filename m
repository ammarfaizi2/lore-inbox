Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269935AbUH0BQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269935AbUH0BQY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269933AbUH0BQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:16:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53176 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269861AbUH0A75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:59:57 -0400
Date: Thu, 26 Aug 2004 17:59:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: maintaining DRM and using bitkeeper..
Message-Id: <20040826175937.1da66716.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408270043170.25111@skynet>
References: <Pine.LNX.4.58.0408270043170.25111@skynet>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 00:57:56 +0100 (IST)
Dave Airlie <airlied@linux.ie> wrote:

> it takes most of an evening to clone a tree to my
> machine at home

Why?

You should always have a current vanilla linus-2.6 BK tree
locally, and just pull into it occaisionally.  Then when
you want to do work just clone it using links:

	bk clone -l linus-2.6 drm-2.6

and fire away. This is the fastest way.

If you're going:

	bk clone bk://linux.bkbits.net/linux-2.5 drm-2.6

then no wonder it takes all evening :-)

When I rebase I just go:

	cd linus-2.6
	bk pull
	cd ..
	mv tree treework
	bk clone -l linus-2.6 tree
	cd tree
	bk pull ../treework

and that takes less than 10 minutes even on my super slow
UltraSPARC machines :-)
