Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311424AbSC1B44>; Wed, 27 Mar 2002 20:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311463AbSC1B4g>; Wed, 27 Mar 2002 20:56:36 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:33927 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S311424AbSC1B4d>; Wed, 27 Mar 2002 20:56:33 -0500
Message-Id: <5.1.0.14.2.20020327175258.08c69e70@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 27 Mar 2002 17:55:50 -0800
To: "David S. Miller" <davem@redhat.com>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: [PATCH] ATM locking fix.
Cc: rml@tech9.net, fisaksen@bewan.com, mitch@sfgoth.com,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        alan@redhat.com, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20020326.145202.122762468.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I'm applying this patch with some minor cleanups of my own.
Ok. And don't forget a patch sent by Francois on top of mine.

>I went and then checked around for atm_find_dev() users to
>make sure they held the atm_dev_lock, and I discovered several pieces
>of "hidden treasure".
Hmm, I thought I check all of them.

>Firstly, have a look at net/atm/common.c:atm_ioctl() and how it
>accesses userspace while holding atm_dev_lock.  That is just the
>tip of the iceberg.
Yeah, that's what I said from the very beginning. ATM locking is messed up.

Max


