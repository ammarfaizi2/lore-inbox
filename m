Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbUANIrm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 03:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbUANIrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 03:47:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51342 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265071AbUANIrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 03:47:40 -0500
Date: Wed, 14 Jan 2004 03:47:22 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, jh@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compilation on gcc 3.4
Message-ID: <20040114084721.GP31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040114083700.GA1820@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114083700.GA1820@averell>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 09:37:00AM +0100, Andi Kleen wrote:
> 
> The upcomming gcc 3.4 has a new inlining algorithm which sometimes
> fails to inline some "dumb" inlines in the kernel. This sometimes leads
> to undefined symbols while linking.

It fails to inline routines with always_inline attribute?
That sounds like a gcc bug.  always_inline should mean inline always,
and issue error if for some reason it is impossible.

	Jakub
