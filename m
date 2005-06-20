Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVFTKyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVFTKyz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVFTKyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:54:54 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62157 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261199AbVFTKyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:54:36 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 0/5] random crypto cleanups
Date: Mon, 20 Jun 2005 13:54:22 +0300
User-Agent: KMail/1.5.4
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506201354.22187.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.be_le.patch:
Introduce {load/store}_{be/le}{32/64}() macros
and use them instead of open-coded conversions.
Introduce BYTEn() macros for extraction of n'th
byte from wider integers and use it.

2.wp.patch:
Fix gcc3.4.3 -O2 whirlpool stack overflow.

3.tf.patch:
Dramatically reduce size of twofish key setup code
with modest increase of key setup time.

4.rot64.patch:
Introduce 64bit rotations (generic + i386 asm),
convert few existing places to use it.
Per previous comments, replace inline -> __inline__
in headers.

z.patch:
use BYTEn() in more places, simplify some tgr192.c bits

Cumulative patch was tested with tcrypt.

Please apply patches 1-4, comment on z.patch.

Patches will be mailed as replies.
--
vda

