Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVC2H1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVC2H1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVC2H0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:26:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:35993 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262503AbVC2HNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:13:10 -0500
Date: Mon, 28 Mar 2005 23:12:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: kfree(null) is unlikely
Message-Id: <20050328231258.053dac28.akpm@osdl.org>
In-Reply-To: <4248FE3C.6030906@pobox.com>
References: <200503290507.j2T57k3U017427@hera.kernel.org>
	<4248FE3C.6030906@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Linux Kernel Mailing List wrote:
> > ChangeSet 1.2231.1.8, 2005/03/28 19:18:25-08:00, akpm@osdl.org
> > 
> > 	[PATCH] slab: kfree(null) is unlikely
> > 	
> > 	- mark kfree(NULL) as being unlikely
> 
> This is just a wild guess, right?

More like a judgement based on experience?

> Seems to me, it depends on the code.
> 

If someone is doing kfree(0) with sufficient frequency for this patch to
matter, then they need to stop doing that, rather than pessimising kfree(not 0).
