Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbTEWGbu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTEWGbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:31:50 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:3727 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S263643AbTEWGbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:31:49 -0400
Subject: Re: [PATCH] Shared crc32 for 2.4.
From: David Woodhouse <dwmw2@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.55L.0305221723140.32401@freak.distro.conectiva>
References: <1053193432.9218.13.camel@imladris.demon.co.uk>
	 <Pine.LNX.4.55L.0305221723140.32401@freak.distro.conectiva>
Content-Type: text/plain
Organization: 
Message-Id: <1053637872.21582.702.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Fri, 23 May 2003 07:44:52 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-22 at 21:23, Marcelo Tosatti wrote:
> Lets wait for 2.4.22pre.

OK. It currently looks like this...

ChangeSet@1.1212, 2003-05-22 22:07:44+01:00, dwmw2@dwmw2.baythorne.internal
  Fix CONFIG_CRC32=y when nothing in-kernel uses CRC32 functions
  by exporting the symbol from kernel/ksyms.c instead of lib/crc32.c,
  hence forcing lib/crc32.o to get pulled in during the final link.
 
ChangeSet@1.1211, 2003-05-19 14:31:55+01:00, dwmw2@dwmw2.baythorne.internal
  Add config help for CONFIG_CRC32 (Duncan Sands <baldrick@wanadoo.fr>)
 
ChangeSet@1.1210, 2003-05-17 18:34:20+01:00, dwmw2@dwmw2.baythorne.internal
  Switch to shared optimised CRC32 functions.

-- 
dwmw2


