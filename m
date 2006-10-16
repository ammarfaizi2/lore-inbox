Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWJPFCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWJPFCB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 01:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWJPFCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 01:02:01 -0400
Received: from mail.gmx.de ([213.165.64.20]:20889 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751460AbWJPFCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 01:02:00 -0400
X-Authenticated: #14349625
Subject: Re: Major slab mem leak with 2.6.17 / GCC 4.1.1
From: Mike Galbraith <efault@gmx.de>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       "nmeyers@vestmark.com" <nmeyers@vestmark.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1160899154.5935.19.camel@Homer.simpson.net>
References: <20061013004918.GA8551@viviport.com>
	 <84144f020610122256p7f615f93lc6d8dcce7be39284@mail.gmail.com>
	 <b0943d9e0610130459w22e6b9a1g57ee67a2c2b97f81@mail.gmail.com>
	 <1160899154.5935.19.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 05:32:32 +0000
Message-Id: <1160976752.6477.3.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-15 at 07:59 +0000, Mike Galbraith wrote:

> 2.6.19-rc1 + patch-2.6.19-rc1-kmemleak-0.11 compiles fine now (unless
> CONFIG_DEBUG_KEEP_INIT is set), boots and runs too.. but axle grease
> runs a lot faster ;-)  I'll try a stripped down config sometime.

My roughly three orders of magnitude (amusing to watch:) boot slowdown
turned out to be stack unwinding.  With CONFIG_UNWIND_INFO disabled,
2.6.19-rc2 + patch-2.6.19-rc1-kmemleak-0.11 runs just fine.

	-Mike

