Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268120AbUI3Bup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268120AbUI3Bup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 21:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268129AbUI3Bup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 21:50:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:641 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268120AbUI3Buo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 21:50:44 -0400
Date: Wed, 29 Sep 2004 21:40:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: herbert@gondor.apana.org.au, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, mdz@canonical.com
Subject: Re: [PATCH] Use msleep_interruptible for therm_adt7467.c kernel
 thread
Message-Id: <20040929214033.4d800242.akpm@osdl.org>
In-Reply-To: <1096289501.9930.19.camel@localhost.localdomain>
References: <20040927102552.GA19183@gondor.apana.org.au>
	<1096289501.9930.19.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Llu, 2004-09-27 at 11:25, Herbert Xu wrote:
> > The continue is just paranoia in case something relies on the sleep
> > to take 2 seconds or more.
> 
> If the signal occurs then you'll spin for 2 seconds because the signal
> is still waiting to be serviced. This therefore looks broken

It's a kernel thread, so unless it has taken explicit action to enable
signals, it should be OK.
