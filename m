Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264578AbUDUCwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbUDUCwH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 22:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbUDUCwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 22:52:07 -0400
Received: from hera.kernel.org ([63.209.29.2]:14056 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264578AbUDUCwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 22:52:04 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: pts having the same device number.
Date: Wed, 21 Apr 2004 02:51:50 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c64nk6$iu7$1@terminus.zytor.com>
References: <40859891.8080208@dlfp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1082515910 19400 63.209.29.3 (21 Apr 2004 02:51:50 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 21 Apr 2004 02:51:50 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <40859891.8080208@dlfp.org>
By author:    matthieu <mat_@dlfp.org>
In newsgroup: linux.dev.kernel
>
> Hello,
> on 2.6.4 I have seen that two pts device can have the same number :
> $ls -l /dev/pts/
> total 0
> crw--w----    1 mat      tty      136,   2 2004-04-20 23:15 2562
> crw--w----    1 mat      tty      136,   2 2004-04-20 23:15 2818
> 
> Is that normal ?
> 

Your libc or ls is old.  They actually have the device numbers
136,2562 and 136,2818 but you only see the bottom 8 bits:

	2562 & 255 = 2
	2818 & 255 = 2

This doesn't affect proper operation, it just affects the output from
ls.

	-hpa

