Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbUAZSZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 13:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbUAZSZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 13:25:10 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:27587 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263639AbUAZSZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 13:25:06 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [2.6.2-rc2] bttv oops
Date: 26 Jan 2004 19:16:43 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87wu7evalw.fsf@bytesex.org>
References: <200401261829.31719.bernd-schubert@web.de>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1075141003 4936 127.0.0.1 (26 Jan 2004 18:16:43 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert <bernd-schubert@web.de> writes:

> Hello,
> 
> on loading the bttv driver I get the following messages:
> 
> EIP is at i2c_master_recv+0xc3/0x110 [i2c_core]

The debug printk's in i2c_core dereferences pointers without checking
them first ...

Workaround:  Disable the i2c debug config options.

  Gerd

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins
