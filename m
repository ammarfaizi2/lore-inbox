Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271002AbTGVS5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271004AbTGVS5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:57:43 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:6672 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S271002AbTGVS5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:57:41 -0400
Date: Tue, 22 Jul 2003 21:12:41 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Xiaoji Liu <xiaoji14@yahoo.com>, Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: kernel image compile ok, but modules compile failed
Message-ID: <20030722191241.GA2003@mars.ravnborg.org>
Mail-Followup-To: Xiaoji Liu <xiaoji14@yahoo.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030722184842.76569.qmail@web41906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722184842.76569.qmail@web41906.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 11:48:42AM -0700, Xiaoji Liu wrote:
> Hello,
> 
> when i compile kernel 2.6.0-test1
> It gave 'parse error' message when compiling file
> drivers/mtd/devices/blkmtd.c
> (around line 700)
> 
> I opened the source file and saw this:
> 
> static int blkmtd_write(struct mtd_info *mtd, loff_t
> to, size_t len,
> size_t *retlen, const u_char *buf)
> {
> mtd_raw_dev_data_t *rawdevice = mtd->priv;
> int err = 0;
> int offset;
> int pagenr;
> size_t len1 = 0, len2 = 0, len3 = 0;
> struct page **pages;
> int pagecnt = 0;
> char b[BDEVNAME_SIZE];
> 21 e3
> *retlen = 0;

They where added by Andrew by accident, and can safely be deleted.
It was part of the "[PATCH] make the bdevname() API sane"
that involved several files.

	Sam
