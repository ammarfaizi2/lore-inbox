Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbUAOQ41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 11:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbUAOQ41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 11:56:27 -0500
Received: from ultra12.almamedia.fi ([193.209.83.38]:38288 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S263742AbUAOQ40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 11:56:26 -0500
Message-ID: <4006C665.3065DFA1@users.sourceforge.net>
Date: Thu, 15 Jan 2004 18:57:09 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jim Faulkner <jfaulkne@ccs.neu.edu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
References: <Pine.GSO.4.58.0401141357410.10111@denali.ccs.neu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Faulkner wrote:
> I am experiencing data corruption on my AES cryptoloop partition under
> recent -mm kernels (including 2.6.1-mm3).  I am unsure how long this
> problem has existed, and I am unsure if this problem exists in the
> mainstream kernel (I can't test it because of an aic7xxx bug in the
> mainstream kernel).

This bug is fixed in loop-AES package. In addition to this bug fix it fixes
many other bugs as well, and achieves correct write ordering when used with
journaling file systems.

http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.0d.tar.bz2
http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.0d.tar.bz2.sign

Jim,
If you want your data secure, you need to re-encrypt your data anyway.
Mainline loop crypto implementation has exploitable vulnerability that is
equivalent to back door. Kerneli.org folks have always shipped back-doored
loop crypto, and now mainline folks are shipping back-doored loop crypto.
Kerneli.org derivatives such as Debian, SuSE, and others are also
back-doored.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
