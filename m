Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTFLJMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 05:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbTFLJMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 05:12:45 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:14262 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263597AbTFLJMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 05:12:40 -0400
Date: Thu, 12 Jun 2003 11:25:48 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: need help with oaknet.c
Message-ID: <20030612092548.GA1718@wohnheim.fh-wedel.de>
References: <20030612090503.GA24365@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030612090503.GA24365@codeblau.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 June 2003 11:05:03 +0200, Felix von Leitner wrote:
> Envelope-to: joern@wohnheim.fh-wedel.de
> Delivery-date: Thu, 12 Jun 2003 11:06:56 +0200
> From:	Felix von Leitner <felix-kernel@fefe.de>
> To:	linux-kernel@vger.kernel.org
> Subject: need help with oaknet.c
> X-Mailing-List:	linux-kernel@vger.kernel.org
> 
> Hi Grant,
> 
> I'm trying to cross compile a linux 2.5.70 kernel to ppc, and after
> removing a few obstacles I'm now stuck in oaknet.c, which bears your
> email address.

Did I miss something or did you forget something in To: or CC:?

> Here are the compile errors.  I have no idea where I can get an
> asm/board.h and a grep did not find the missing defines.
> 
> drivers/net/oaknet.c:24:23: asm/board.h: No such file or directory
> drivers/net/oaknet.c: In function `oaknet_init':
> drivers/net/oaknet.c:102: error: `OAKNET_IO_BASE' undeclared (first use
> in this function)

include/asm-ppc/board.h got removed somewhere between 2.4.19 and
2.4.20 (and between 2.5.0 and 2.5.70, search yourself).  Quick fix
without thinking is to grab the one from 2.4.19 and add it to 2.5.70.
If you want a working system, a bit thinking might help though. :)

Jörn

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
-- Theodore Roosevelt, Kansas City Star, 1918
