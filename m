Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTD3Xov (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbTD3Xov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:44:51 -0400
Received: from pointblue.com.pl ([62.89.73.6]:45581 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262547AbTD3Xou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:44:50 -0400
Subject: Re: 2.5.68-bk10 blkmtd.c:219: warning: implicit declaration of
	function `alloc_kiovec'
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rddunlap@osdl.org>
In-Reply-To: <1051745126.5274.22.camel@flat41>
References: <1051745126.5274.22.camel@flat41>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1051747119.5315.28.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 May 2003 00:58:39 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-01 at 00:25, Grzegorz Jaskiewicz wrote:
> Well, "burned" on ieee1394 i will not try to patch it my self :)
> Anyway, i can live without those drivers :)


> drivers/mtd/devices/blkmtd.c:52:25: linux/iobuf.h: No such file or
> directory

I've tried to investigate this. What happend to iobuf.{ch} ? 
I guess bit more changes are required to make it running before 2.6 :)

Btw, authors email in head of blkmtd.c is bad.

Fanny thing, after removing this include there is declaration :

/* readpage() - reads one page from the block device */
static int blkmtd_readpage(mtd_raw_dev_data_t *rawdevice, struct page *page)
{
  int err;
  int sectornr, sectors, i;
  struct kiobuf *iobuf;
	^^^^^^^
  unsigned long *blocks;

Fast fgrep in kernel sources gives me no answer about this structure declaration.

any help guys ?

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

