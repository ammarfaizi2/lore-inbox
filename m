Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSHGKsW>; Wed, 7 Aug 2002 06:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317110AbSHGKsW>; Wed, 7 Aug 2002 06:48:22 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24825 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317054AbSHGKsV>; Wed, 7 Aug 2002 06:48:21 -0400
Subject: Re: kernel thread exit race
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
In-Reply-To: <15696.61666.452460.264138@laputa.namesys.com>
References: <15696.59115.395706.489896@laputa.namesys.com>
	<1028719111.18156.227.camel@irongate.swansea.linux.org.uk> 
	<15696.61666.452460.264138@laputa.namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 13:11:23 +0100
Message-Id: <1028722283.18156.274.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 11:05, Nikita Danilov wrote:
> Ah I see, thank you and Russell. But this depends on no architecture
> ever accessing spinlock data after letting waiters to run, otherwise
> there still is (tiny) window for race at the end of complete() call,
> right?

complete() as opposed to spinlocks/semaphores is defined to be safe to
free the object once the complete finishes

