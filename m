Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267085AbTBCWol>; Mon, 3 Feb 2003 17:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267091AbTBCWol>; Mon, 3 Feb 2003 17:44:41 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:61099 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S267085AbTBCWok>; Mon, 3 Feb 2003 17:44:40 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1044292722.21009.9.camel@irongate.swansea.linux.org.uk>
References: <1044284924.2402.12.camel@gregs>
	<1044289102.21009.1.camel@irongate.swansea.linux.org.uk>
	<1044286828.2397.26.camel@gregs> 
	<1044292722.21009.9.camel@irongate.swansea.linux.org.uk>
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Feb 2003 22:54:06 +0000
Message-Id: <1044312846.28406.31.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 17:18, Alan Cox wrote:

> If I build the example using the cleanups I suggested it works for me. The FPU one btw
> seems to be a red herring, my gcc is outputting a precomputed integer constant

This is purely coincidence. GCC is perfectly entitled to use integer
arithmetic even though you used floats in the source.

GCC is likewise perfectly entitled to use floating point even if you
only used integers in the source. There's a good reason why the SH port
builds with '-mno-implicit-fp' and why all other ports should have this
_before_ it becomes a problem rather than afterwards.

-- 
dwmw2

