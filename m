Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270991AbTGVSdl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270992AbTGVSdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:33:41 -0400
Received: from web41906.mail.yahoo.com ([66.218.93.157]:60597 "HELO
	web41906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270991AbTGVSdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:33:38 -0400
Message-ID: <20030722184842.76569.qmail@web41906.mail.yahoo.com>
Date: Tue, 22 Jul 2003 11:48:42 -0700 (PDT)
From: Xiaoji Liu <xiaoji14@yahoo.com>
Subject: 2.6.0-test1: kernel image compile ok, but modules compile failed
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when i compile kernel 2.6.0-test1
It gave 'parse error' message when compiling file
drivers/mtd/devices/blkmtd.c
(around line 700)

I opened the source file and saw this:

static int blkmtd_write(struct mtd_info *mtd, loff_t
to, size_t len,
size_t *retlen, const u_char *buf)
{
mtd_raw_dev_data_t *rawdevice = mtd->priv;
int err = 0;
int offset;
int pagenr;
size_t len1 = 0, len2 = 0, len3 = 0;
struct page **pages;
int pagecnt = 0;
char b[BDEVNAME_SIZE];
21 e3
*retlen = 0;
DEBUG(2, "blkmtd: write: dev = `%s' to = %ld len = %d
buf = %p\n",
bdevname(rawdevice->binding, b), (long int)to, len,
buf);

/* handle readonly and out of range numbers */

Notice there is a line : 21 e3

please give some suggestion
THX


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
