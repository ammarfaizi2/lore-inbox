Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272609AbTHKNx7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272585AbTHKNxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:53:46 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:43500 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S272609AbTHKNxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:53:22 -0400
Subject: Re: compiling external kernel modules (comedi.org)
From: David Woodhouse <dwmw2@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Bernd Porr <Bernd.Porr@cn.stir.ac.uk>, linux-kernel@vger.kernel.org,
       comedi@comedi.org
In-Reply-To: <20030802230553.GA1188@mars.ravnborg.org>
References: <3F2B0E06.9000907@cn.stir.ac.uk>
	 <20030802070422.GA2404@mars.ravnborg.org> <3F2BA623.6030906@cn.stir.ac.uk>
	 <20030802120756.GA964@mars.ravnborg.org> <3F2BB840.9060205@cn.stir.ac.uk>
	 <20030802230553.GA1188@mars.ravnborg.org>
Content-Type: text/plain
Message-Id: <1060609994.32631.3.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (dwmw2) 
Date: Mon, 11 Aug 2003 14:53:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-03 at 00:05, Sam Ravnborg wrote:
> EXTRA_CFLAGS := -I$(obj)/../include
> in the Makefile should do the trick.

Be careful -- in the case where you're building a newer driver than one
which is already in the kernel, you may need to ensure your own include
directory supersedes the kernel's. In that case 'CC=$(CROSS_COMPILE)gcc
-I$(obj)/../include' may be useful.

An example which is currently working for 2.4 and 2.6 kernels, and which
used to work for 2.2 too until quite recently, is at
http://cvs.infradead.org/cgi-bin/cvsweb.cgi/mtd/drivers/mtd/

Some people seem to think that the 'SUBDIRS=' trick is a new thing for
2.6. It's not -- it's worked for ever, and was _always_ the only
reliable way of building modules to match the kernel.


-- 
dwmw2

