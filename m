Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270611AbTGTDMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 23:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270612AbTGTDMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 23:12:55 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:63990 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S270611AbTGTDMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 23:12:54 -0400
Date: Sat, 19 Jul 2003 23:28:04 -0400
From: Matt Reppert <repp0017@tc.umn.edu>
To: Pedro Ribeiro <deadheart@netcabo.pt>, linux-kernel@vger.kernel.org
Subject: Re: Problem with mii-tool && 2.6.0-test1-ac2
Message-Id: <20030719232804.08cc3689.repp0017@tc.umn.edu>
In-Reply-To: <3F198C66.1030405@netcabo.pt>
References: <3F198C66.1030405@netcabo.pt>
Organization: Arashi no Kaze
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jul 2003 19:22:30 +0100
Pedro Ribeiro <deadheart@netcabo.pt> wrote:

> If I compile the 8139 ethernet support as a module (as I always did - 
> module name >> 8130too) I will get an error in make modules_install. 
> However, if I build it in the kernel it will work just fine. The problem 
> is that now when I try to do a simple mii-tool -F 100baseTX-FD eth0 
> (because my eth always stats at 100 Half duplex) I get this error:
> 
> SIOCGMIIPHY on 'eth0' failed: Operation not supported

What's the error you get on install? I don't have a problem doing it on
my iBook.

You have to explicitly turn on MII support in 2.6-test; the kconfig option
is CONFIG_MII; it's "Generic Media Independent Interface device support",
the first item under "Ethernet (10 or 100Mbit)". This needs to be modular or
on to use mii-tool, I imagine.

Matt
