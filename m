Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262344AbSJVJ61>; Tue, 22 Oct 2002 05:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262364AbSJVJ61>; Tue, 22 Oct 2002 05:58:27 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:55735 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262344AbSJVJ61>; Tue, 22 Oct 2002 05:58:27 -0400
Subject: Re: Small oddity of the week: 2.4.20-pre
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alastair Stevens <alastair@camlinux.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1034431251.2688.64.camel@dolphin.entropy.net>
References: <1034431251.2688.64.camel@dolphin.entropy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 11:20:41 +0100
Message-Id: <1035282041.31873.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-12 at 15:00, Alastair Stevens wrote:
> I consulted the developer, and we tracked the problem down to this
> pathetically innocent command sequence in the script:
> 
>     fdisk -l | grep -w "/dev/hda6"
> 
> For some reason, this now produces, entirely at _random_, either one or
> two lines of output! It was the duplicated output that broke Mindi. It's
> easily accommodated in the script, but this randomness was never
> exhibited on any earlier kernels. Is it me, or is this weird?

It would be weird but for having known people who hit the same. The file
can change as its being read (especially with stats in it). You may find
that you need to do a single large read of the /proc file

