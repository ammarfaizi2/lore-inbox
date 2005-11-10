Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751685AbVKJDBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbVKJDBw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 22:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbVKJDBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 22:01:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24498 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751684AbVKJDBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 22:01:51 -0500
Date: Wed, 9 Nov 2005 19:01:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] mm: atomic64 page counts
Message-Id: <20051109190135.45e59298.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511100224030.6215@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511100156320.5814@goblin.wat.veritas.com>
	<20051109181641.4b627eee.akpm@osdl.org>
	<Pine.LNX.4.61.0511100224030.6215@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> ...
>
> I'm quite pleased with the way it's worked out, but you were intending
> that the 64-bit arches should get along with 32-bit counts?  Maybe.

That seems reasonsable for file pages.  For the ZERO_PAGE the count can do
whatever it wants, because we'd never free them up.

