Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbSIZPK1>; Thu, 26 Sep 2002 11:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbSIZPK1>; Thu, 26 Sep 2002 11:10:27 -0400
Received: from [217.167.51.129] ([217.167.51.129]:25584 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261369AbSIZPJR>;
	Thu, 26 Sep 2002 11:09:17 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linus Torvalds" <torvalds@transmeta.com>,
       "Andre Hedrick" <andre@linux-ide.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Jens Axboe" <axboe@suse.de>
Subject: Re: [PATCH] fix ide-iops for big endian archs
Date: Thu, 26 Sep 2002 17:14:14 +0200
Message-Id: <20020926151414.26040@192.168.4.1>
In-Reply-To: <1033052967.1348.30.camel@irongate.swansea.linux.org.uk>
References: <1033052967.1348.30.camel@irongate.swansea.linux.org.uk>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, 2002-09-25 at 13:32, Benjamin Herrenschmidt wrote:
>> I enclosed the patch as an attachement too in case the mailer screws
>> it up...
>
>Please do one thing. For the stuff that needs weird powerpcisms put all
>the seperate stuff in one block with its own copy of the static inlines
>so we dont have in ifdef in half the functions in the file

This is _NOT_ a weird PowerPC'ism !!!

It's just a matter of use the proper operation, that is "insw/outsw"
instead of trying to re-implement it with a loop of basic inw/outw,
which is wrong for _any_ BE arch (except maybe weird m68k'ism where
IDE is wired the wrong way around)

Ben.


