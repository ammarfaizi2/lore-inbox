Return-Path: <linux-kernel-owner+willy=40w.ods.org-S386181AbUKBAiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S386181AbUKBAiK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S277078AbUKBAOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:14:36 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:56725 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S384351AbUKBAFu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:05:50 -0500
Subject: Re: [PATCH 10/14] FRV: Make calibrate_delay() optional
From: john stultz <johnstul@us.ibm.com>
To: dhowells@redhat.com
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       davidm@snapgear.com, lkml <linux-kernel@vger.kernel.org>,
       uclinux-dev@uclinux.org
In-Reply-To: <200411011930.iA1JULKN023227@warthog.cambridge.redhat.com>
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
	 <200411011930.iA1JULKN023227@warthog.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1099353962.9139.11.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 01 Nov 2004 16:06:03 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-01 at 11:30, dhowells@redhat.com wrote:
> The attached patch makes calibrate_delay() optional. In this architecture, it's
> a waste of time since we can predict exactly what it's going to come up with
> just by looking at the CPU's hardware clock registers. Thus far, we haven't
> seem a board with any clock not dependent on the CPU's clock.

Just doing a quick skim, the patch looks good. Making a whole new file
for just one function is a bit heavy handed, but I don't feel that code
needed to be in main.c

My only nit would be to save the tabs and switch the code from:

if (preset_lpj) {
	newstuff
} else {
	oldstuff
}

to

if (preset_lpj) {
	newstuff
	return
}
oldstuff


thanks
-john

