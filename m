Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbUA1TZG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUA1TYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:24:53 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:4032 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266161AbUA1TYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:24:03 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: long long on 32-bit machines
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Cc: =?iso-8859-1?Q? "H=2E_Peter_Anvin" ?= <hpa@zytor.com>
Message-Id: <26879984$107531702940180925001758.71044950@config16.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 26879984
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Wed, 28 Jan 2004 20:22:01 +0100
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.143
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


H.P.A wrote:

> Does anyone happen to know if there are *any* 32-bit architectures (on 
> which Linux runs) for which the ABI for a "long long" is different from 
> passing two "longs" in the appropriate order, i.e. (hi,lo) for bigendian 
> or (lo,hi) for littleendian?

Some architectures require long long arguments to be passed as an
even/odd register pair. For example on s390, 

   void f(int a, int b, long long x) 

uses registers 2, 3, 4 and 5, while 

   void f(int a, long long x, int b)

uses registers 2, 4, 5 and 6. AFAIK, mips does the same, probably others
as well.

       Arnd <><
