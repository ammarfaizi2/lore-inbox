Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265413AbSJXLcn>; Thu, 24 Oct 2002 07:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbSJXLcm>; Thu, 24 Oct 2002 07:32:42 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:7619 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265413AbSJXLcm>; Thu, 24 Oct 2002 07:32:42 -0400
Subject: Re: One for the Security Guru's
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hps@intermeta.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <ap8kdl$bae$1@forge.intermeta.de>
References: <20021023130251.GF25422@rdlg.net>
	<1035411315.5377.8.camel@god.stev.org>
	<20021024101126.GQ147946@niksula.cs.hut.fi> 
	<ap8kdl$bae$1@forge.intermeta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 12:55:49 +0100
Message-Id: <1035460549.8675.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 12:09, Henning P. Schmiedehausen wrote:
> Ville Herva <vherva@niksula.hut.fi> writes:
> 
> >the /dev/kmem hole, but this closes 2 classes of attacks - loading rootkit
> >module and booting with a hacked kernel in straight-forward way.
> 
> Question: What do I lose when you remove /dev/kmem?
> Related question: Would it be useful to make /dev/kmem read-only? 

Makes no real difference. If the user got to root they can work the
chmod command. What you want to do is revoke CAP_SYS_RAWIO which kills
off all direct hardware access - mem/kmem/iopl/ioperm etc. It does stop
non kernel fb X working but thats not a big deal on a server.

