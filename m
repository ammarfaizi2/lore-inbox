Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263549AbTETNbI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 09:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbTETNbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 09:31:08 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:58602 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S263549AbTETNbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 09:31:08 -0400
Date: Tue, 20 May 2003 15:44:00 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Pawan Deepika <pawan_deepika@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux 2.4.18] via-rhine.c
Message-ID: <20030520134400.GB25041@k3.hellgate.ch>
Mail-Followup-To: Pawan Deepika <pawan_deepika@yahoo.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030519194317.20999.qmail@web41606.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030519194317.20999.qmail@web41606.mail.yahoo.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.68 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should ask this kind of questions on the kernelnewbies list.

On Mon, 19 May 2003 12:43:17 -0700, Pawan Deepika wrote:
> through the source code in via-rhine.c. What I
> understand till now is that in Memory-mapped devices,
> I/O operation is performed using
> read(b/w/l)/write(b/w/l) functions while in IO mapped
> devices it is done using in/out(b/w/l). Am I right?

What you do with inb etc. is called PIO (Programmed I/O).

> But in via-rhine.c I notice use of inb and outb even
> in memory mapped case(code is shown below)
> 
> ------------------------------------------------------
> #ifdef USE_MEM
> 530 static void __devinit enable_mmio(long ioaddr, int
> chip_id)
> 531 {

It does exactly what the function name says: it uses PIO to flip a bit in
some register to enable MMIO, which is just a different (and better) way to
transfer the data.

Roger
