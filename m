Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbVKNJXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVKNJXe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 04:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVKNJXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 04:23:33 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:61885 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751026AbVKNJXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 04:23:33 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
To: Jason Dravet <dravet@hotmail.com>, adaplas@gmail.com,
       samuel.thibault@ens-lyon.org, torvalds@osdl.org, akpm@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Mon, 14 Nov 2005 10:24:02 +0100
References: <58DvZ-6en-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EbaZH-0000cM-LC@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Dravet <dravet@hotmail.com> wrote:

> When I run stty rows 20 I get a screen of 80x20.  I can see the top 10 rows
> and the bottom 10 rows are invisible.

I asume your VGA indicates that it'll divide it's scanline counter by 2.
Please add a printk("vgacon: mode=%2.2x\n", mode) before line 512 and report
the value. A real fix will depend on this value. In the meantime, removing
the lines 512 and 513 from the original file should be a temporary fix.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
