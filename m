Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273364AbRKKJ7g>; Sun, 11 Nov 2001 04:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274813AbRKKJ71>; Sun, 11 Nov 2001 04:59:27 -0500
Received: from yuha.menta.net ([212.78.128.42]:181 "EHLO yuha.menta.net")
	by vger.kernel.org with ESMTP id <S273364AbRKKJ7O>;
	Sun, 11 Nov 2001 04:59:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ivanovich <ivanovich@menta.net>
To: Peter Klotz <peter.klotz@aon.at>, linux-kernel@vger.kernel.org
Subject: Re: Error message during modules_install of 2.4.14
Date: Sun, 11 Nov 2001 10:58:45 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <01111110010300.23755@localhost.localdomain>
In-Reply-To: <01111110010300.23755@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <01111110584500.01260@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 November 2001 10:01, Peter Klotz wrote:

> During "make modules_install" I got the following error message:
>
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
> pcmcia if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.14;
> fi depmod: *** Unresolved symbols in
> /lib/modules/2.4.14/kernel/drivers/block/loop.o
> depmod:         deactivate_page
>
> Is this something to worry about?

There is a problem with the loopback device in 2.4.14

looking at the changelog of 2.4.15-pre1 it seems to be fixed:
pre1:
(...)
 - various: fix loop driver that thought it was part of the VM system
