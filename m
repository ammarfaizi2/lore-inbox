Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288028AbSA3C10>; Tue, 29 Jan 2002 21:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288050AbSA3C1P>; Tue, 29 Jan 2002 21:27:15 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:28550 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S288028AbSA3C1J>; Tue, 29 Jan 2002 21:27:09 -0500
Date: Wed, 30 Jan 2002 05:26:43 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Mingming cao <cmm@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, linux-raid@vger.kernel.org
Subject: Re: Could not compile md/raid5.c and md/multipath.c in 2.5.3-pre3
Message-Id: <20020130052643.5a0a8f61.johnpol@2ka.mipt.ru>
In-Reply-To: <3C575435.C123186@us.ibm.com>
In-Reply-To: <3C571DB2.4E0C0436@us.ibm.com>
	<20020130042025.051ee424.johnpol@2ka.mipt.ru>
	<3C575435.C123186@us.ibm.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002 18:02:29 -0800
Mingming cao <cmm@us.ibm.com> wrote:

> I omitted similar compile errors in the last email.  raid5.c and
> multipath.c referenced a lot data structures defined in
> md_compatible.h,  besides the two you added in your fix......

As you mention md_compatible.h does not exist, it was introduced in 2.5.2
patch only in drivers/md/xor.c. But in at least pre5 all structures were
correctly defined in various md_{p,u,k}.h files. I've tried to find others
undefined symbols, but cann't. So i suggest you to upgrade a bit to pre6
or pre5 kernel ;), apply my litle patch and remove mention of
md_compatible.h in drivers/md/xor.c. And feel free to write all others
erorrs, if they will appear again.

> Thank you for your help.

Good luck.

> -- 
> Mingming Cao


	Evgeniy Polyakov ( s0mbre ).
