Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbSLRIiw>; Wed, 18 Dec 2002 03:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbSLRIiw>; Wed, 18 Dec 2002 03:38:52 -0500
Received: from khms.westfalen.de ([62.153.201.243]:32993 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S265754AbSLRIiw>; Wed, 18 Dec 2002 03:38:52 -0500
Date: 18 Dec 2002 09:20:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8c6-Z4kHw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0212171157050.1095-100000@home.transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.3.95.1021217144308.26554A-100000@chaos.analogic.com> <Pine.LNX.4.44.0212171157050.1095-100000@home.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 17.12.02 in <Pine.LNX.4.44.0212171157050.1095-100000@home.transmeta.com>:

> On Tue, 17 Dec 2002, Richard B. Johnson wrote:
> >
> > You can call intersegment with a full pointer. I don't know how
> > expensive that is.
>
> It's so expensive as to not be worth it, it's cheaper to load a register
> or something, i eyou can do
>
> 	pushl $0xfffff000
> 	call *(%esp)
>
> faster than doing a far call.

Hmm ...

How expensive would it be to have a special virtual DSO built into ld.so  
which exported this (and any other future entry points), to be linked  
against like any other DSO? That way, the *actual* interface would only be  
between the kernel and ld.so.

MfG Kai
