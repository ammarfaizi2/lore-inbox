Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWBOK0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWBOK0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 05:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWBOK0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 05:26:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29060 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751041AbWBOK0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 05:26:36 -0500
Date: Wed, 15 Feb 2006 02:25:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFT/PATCH] 3c509: use proper suspend/resume API
Message-Id: <20060215022523.1d21b9c9.akpm@osdl.org>
In-Reply-To: <1139935173.22151.2.camel@localhost>
References: <1139935173.22151.2.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> I am looking for someone with 3c509 netword card that can do
>  suspend/resume to test this patch.

I have a 3c509, and I'm not afraid to use it!

Problem is, it doesn't resume correctly either with or without the patch:
it needs rmmod+modprobe to get it going again.  (Which is better than the
aic7xxx driver, which has a coronary and panics the kernel on post-resume
reboot).

But at least nothing got worse, and it makes that darn warning go away.
