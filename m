Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270988AbTGVTKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270992AbTGVTKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:10:21 -0400
Received: from web41903.mail.yahoo.com ([66.218.93.154]:6329 "HELO
	web41903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270988AbTGVTKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:10:17 -0400
Message-ID: <20030722192519.35904.qmail@web41903.mail.yahoo.com>
Date: Tue, 22 Jul 2003 12:25:19 -0700 (PDT)
From: Xiaoji Liu <xiaoji14@yahoo.com>
Subject: Re: 2.6.0-test1: kernel image compile ok, but modules compile failed
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030722191241.GA2003@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Sam Ravnborg <sam@ravnborg.org> wrote:
> On Tue, Jul 22, 2003 at 11:48:42AM -0700, Xiaoji Liu
> wrote:
> > Hello,
> > 
> > when i compile kernel 2.6.0-test1
> > It gave 'parse error' message when compiling file
> > drivers/mtd/devices/blkmtd.c
> > (around line 700)
> > 
> > I opened the source file and saw this:
> > 
> > static int blkmtd_write(struct mtd_info *mtd,
> loff_t
> > to, size_t len,
> > size_t *retlen, const u_char *buf)
> > {
> > mtd_raw_dev_data_t *rawdevice = mtd->priv;
> > int err = 0;
> > int offset;
> > int pagenr;
> > size_t len1 = 0, len2 = 0, len3 = 0;
> > struct page **pages;
> > int pagecnt = 0;
> > char b[BDEVNAME_SIZE];
> > 21 e3
> > *retlen = 0;
> 
> They where added by Andrew by accident, and can
> safely be deleted.
> It was part of the "[PATCH] make the bdevname() API
> sane"
> that involved several files.
> 
> 	Sam

are there any other such problems around? :)


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
