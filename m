Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945927AbWBOMqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945927AbWBOMqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 07:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945925AbWBOMqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 07:46:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945924AbWBOMqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 07:46:16 -0500
Date: Wed, 15 Feb 2006 04:45:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFT/PATCH] 3c509: use proper suspend/resume API
Message-Id: <20060215044510.5b416604.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0602151317110.14223@sbz-30.cs.Helsinki.FI>
References: <1139935173.22151.2.camel@localhost>
	<20060215022523.1d21b9c9.akpm@osdl.org>
	<Pine.LNX.4.58.0602151317110.14223@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
>  Hi Andrew,
> 
>  On Wed, 15 Feb 2006, Andrew Morton wrote:
>  > Problem is, it doesn't resume correctly either with or without the patch:
>  > it needs rmmod+modprobe to get it going again.  (Which is better than the
>  > aic7xxx driver, which has a coronary and panics the kernel on post-resume
>  > reboot).
> 
>  Hmm. Either I am totally confused or we don't even attempt suspend/resume 
>  for eisa and mca bus devices. Care to try this patch?

No, el3_suspend() and el3_resume() don't seem to be called.  And they're
still not called with this patch applied..

(I got one resume in which the 3c509 still worked.  Odd.)
