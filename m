Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261153AbSIWRxH>; Mon, 23 Sep 2002 13:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261165AbSIWRxH>; Mon, 23 Sep 2002 13:53:07 -0400
Received: from zeus.kernel.org ([204.152.189.113]:64654 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261153AbSIWRxG>;
	Mon, 23 Sep 2002 13:53:06 -0400
Message-ID: <3D8F48D9.1D8BE9D@digeo.com>
Date: Mon, 23 Sep 2002 10:01:13 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5.38-mm2
References: <20020923153301.2c87768d.Gregor.Fajdiga@telemach.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 17:01:13.0413 (UTC) FILETIME=[D2A91750:01C26322]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grega Fajdiga wrote:
> 
> Good day,
> 
> I get this oops at startup in 2.5.38-mm2. The oops

It's not an oops - it's just a warning.

> ..
> Trace; c0117826 <__might_sleep+56/5d>
> Trace; c0134386 <kmalloc+66/1f0>
> Trace; c01d2e60 <ide_intr+0/1d0>

ide_intr() is calling sleeping functions inside ide_lock.
