Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267203AbSKPCK3>; Fri, 15 Nov 2002 21:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbSKPCK3>; Fri, 15 Nov 2002 21:10:29 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:47536 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267203AbSKPCK2>; Fri, 15 Nov 2002 21:10:28 -0500
Subject: Re: Reserving "special" port numbers in the kernel ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arun Sharma <arun.sharma@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <uel9mbcyi.fsf@unix-os.sc.intel.com>
References: <uel9mbcyi.fsf@unix-os.sc.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Nov 2002 02:43:58 +0000
Message-Id: <1037414638.21937.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-16 at 00:00, Arun Sharma wrote:
> One of the Intel server platforms has a magic port number (623) that
> it uses for remote server management. However, neither the kernel nor
> glibc are aware of this special port.

I can't find it in the IETF standards documents either.

> As a result, when someone requests a privileged port using
> bindresvport(3), they may get this port back and bad things happen.

They have at least as much right to it as you do

> Has anyone run into this or similar problems before ? Thoughts on
> what's the right place to handle this issue ?

Run your remote management daemon from xinetd, it'll then get the port
nice and early in the system runtime.

