Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSLaQJM>; Tue, 31 Dec 2002 11:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSLaQJL>; Tue, 31 Dec 2002 11:09:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6021
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263321AbSLaQJJ>; Tue, 31 Dec 2002 11:09:09 -0500
Subject: Re: 2.4.21-pre2 IDE problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marijn Ros <marijn@mad.scientist.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87isxa4c1k.fsf@214pc221.sshunet.nl>
References: <87isxa4c1k.fsf@214pc221.sshunet.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Dec 2002 16:59:36 +0000
Message-Id: <1041353976.17415.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-31 at 12:18, Marijn Ros wrote:
> However, when I try the new 2.4.21-pre2 taskfile IO setting, I get a
> 'hda: lost interrupt' message every 30 seconds (the timeout period I
> guess) during disk IO, making the machine unusable. I know this
> setting is experimental, but I guess you would like to know about my
> problems before the old code is phased out completely.

Taskfile I/O as opposed to ioctl is broken for PIO. I know about this
and I've disabled it. I don't plan to fix that path for 2.4 but to keep
the old read/write paths to reduce risk

