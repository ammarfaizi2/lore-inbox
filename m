Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbULBXkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbULBXkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 18:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbULBXkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 18:40:19 -0500
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:62128
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S261744AbULBXkO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 18:40:14 -0500
Date: Thu, 2 Dec 2004 23:40:12 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] misleading error message
In-Reply-To: <41AF0BA5.5080901@blue-labs.org>
Message-ID: <Pine.LNX.4.58.0412022327200.1411@ppg_penguin.kenmoffat.uklinux.net>
References: <001101c4d715$25a59470$af00a8c0@BEBEL>
 <Pine.LNX.4.61.0411302251180.3635@dragon.hygekrogen.localhost>
 <Pine.LNX.4.53.0411302310080.31695@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0411302328450.3635@dragon.hygekrogen.localhost>
 <Pine.LNX.4.53.0411302329550.13758@yvahk01.tjqt.qr> <41AF0BA5.5080901@blue-labs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004, David Ford wrote:

> Random side thoughts..
>
> a) is there a simple way to search for symbols in a running kernel's
> memory area that
> b) can differentiate between module and static, and if so
> c) is there an interest in a tiny tool that scripts  could use to
> determine existing support?
>

 Take a look in /proc/kallsyms when you have a module loaded.  The
addresses are nowhere near the rest of the kernel, and the module names
appear in square brackets at the end of the lines, so something like

grep '\[natsemi\]' /proc/kallsyms

will find out if the natsemi driver is loaded.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

