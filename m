Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUENQLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUENQLm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUENQLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:11:42 -0400
Received: from village.ehouse.ru ([193.111.92.18]:16139 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261648AbUENQLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:11:38 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Will Dyson <will_dyson@pobox.com>
Subject: Re: [PATCH] befs (1/5): LBD support
Date: Fri, 14 May 2004 20:09:36 +0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200405132232.09816.rathamahata@php4.ru> <40A4E432.4020202@pobox.com>
In-Reply-To: <40A4E432.4020202@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405142009.36776.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Will,

On Friday 14 May 2004 19:22, Will Dyson wrote:
> Sergey S. Kostyliov wrote:
> > LBD patch merged long time ago, so it is safe to pass u64 block
> > numbers to sb_bread() when sector_t is large enough.
> 
> Nice. I haven't mounted any of my BeFS volumes in quite some months now. 
>   Are you interested in taking over official maintainership?
>

Yes, I am interested. How do you like this patch?

===== Documentation/filesystems/befs.txt 1.2 vs edited =====
--- 1.2/Documentation/filesystems/befs.txt	Tue Apr  1 03:55:42 2003
+++ edited/Documentation/filesystems/befs.txt	Fri May 14 20:00:47 2004
@@ -17,8 +17,8 @@
 
 AUTHOR
 =====
-Current maintainer: Will Dyson <will_dyson@pobox.com>
-Has been working on the code since Aug 13, 2001. See the changelog for
+The largest part of the code written by Will Dyson <will_dyson@pobox.com>
+He has been working on the code since Aug 13, 2001. See the changelog for
 details.
 
 Original Author: Makoto Kato <m_kato@ga2.so-net.ne.jp>
@@ -26,6 +26,8 @@
 <http://hp.vector.co.jp/authors/VA008030/bfs/>
 Does anyone know of a more current email address for Makoto? He doesn't
 respond to the address given above...
+
+Current maintainer: Sergey S. Kostyliov <rathamahata@php4.ru>
 
 WHAT IS THIS DRIVER?
 ==================

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
