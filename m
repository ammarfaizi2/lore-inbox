Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVLQNIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVLQNIl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 08:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVLQNIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 08:08:41 -0500
Received: from smtp-out-02.utu.fi ([130.232.202.172]:53993 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S932146AbVLQNIl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 08:08:41 -0500
Date: Sat, 17 Dec 2005 15:08:38 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: wrong SWAP values in top's output
In-reply-to: <20051216090826.10626.qmail@web35007.mail.mud.yahoo.com>
To: =?iso-8859-1?q?Jos=E9_Toneh?= <tohnehn@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Message-id: <200512171508.38912.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20051216090826.10626.qmail@web35007.mail.mud.yahoo.com>
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 December 2005 11:08, you wrote:

>        463680  used swap

>   PID %MEM  VIRT SWAP  RES CODE DATA  SHR nFLT nDRT S PR  NI %CPU COMMAND      
> 18551 14.1  345m 273m  71m 1712 343m 101m 1373    0 S 5 -10  4.0 XFree86      
> 25397 49.5  505m 255m 249m  164 505m  40m 3700    0 S 15   0  2.0 mozilla-bin  
> 24759  0.5  236m 234m 2416   16 236m  54m  138    0 S 17   0  0.0 java_vm   

Shared pages and similar?

Seens like top's "SWAP" column is simply VIRT-RES.

Let's not also forget that read-only executable code just gets discarded
from memory, and not pushed to swap. If needed again, it gets read back
in from the file.

Oh, it's supposedly also bad to renice X to -10 with recent kernels ;-)

