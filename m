Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbTAOKVh>; Wed, 15 Jan 2003 05:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbTAOKVg>; Wed, 15 Jan 2003 05:21:36 -0500
Received: from [81.2.122.30] ([81.2.122.30]:9989 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266120AbTAOKVg>;
	Wed, 15 Jan 2003 05:21:36 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301151030.h0FAU3ox000873@darkstar.example.net>
Subject: Re: [RFC] add module reference to struct tty_driver
To: rmk@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jan 2003 10:30:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20030115100001.D31372@flint.arm.linux.org.uk> from "Russell King" at Jan 15, 2003 10:00:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Woah!  Hm, this is going to cause lots of problems in drivers that have
> > been assuming that the BKL is grabbed during module unload, and during
> > open().  Hm, time to just fallback on the argument, "module unloading is
> > unsafe" :(
> 
> Note that its the same in 2.4 as well.  iirc, the BKL was removed from
> module loading/unloading sometime in the 2.3 timeline.

Surely no recent code should be making that assumption anyway - the
BKL is being removed all over the place.

John.
