Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317809AbSGPI6d>; Tue, 16 Jul 2002 04:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317812AbSGPI6c>; Tue, 16 Jul 2002 04:58:32 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:20474 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317809AbSGPI6b>; Tue, 16 Jul 2002 04:58:31 -0400
Subject: Re: [RFC] shrink task_struct by removing per_cpu utime and stime
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020716070943.GL1022@holomorphy.com>
References: <20020716070943.GL1022@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 Jul 2002 11:11:06 +0100
Message-Id: <1026814266.1688.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-16 at 08:09, William Lee Irwin III wrote:
> These statistics severely bloat the task_struct and nothing in
> userspace can rely on them as they're conditional on CONFIG_SMP. If
> anyone is using them (or just wants them around), please speak up.

User space can rely on them because it can check if the data is present.
Some of the graphical process monitors dump per cpu utime/stime. Its
sometimes a good way to cringe at our SMP balancing algorithms in 2.4

