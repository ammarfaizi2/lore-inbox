Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263603AbUFFNMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbUFFNMh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 09:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbUFFNMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 09:12:36 -0400
Received: from fmr12.intel.com ([134.134.136.15]:7854 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S263603AbUFFNMf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 09:12:35 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: idebus setup problem (2.6.7-rc1)
Date: Sun, 6 Jun 2004 21:11:21 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD550B@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: idebus setup problem (2.6.7-rc1)
Thread-Index: AcRKkZN/+rbMzwugQcW1orBd+V9KAQBNl5Mg
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Rusty Russell" <rusty@rustcorp.com.au>
Cc: "Herbert Poetzl" <herbert@13thfloor.at>,
       "Auzanneau Gregory" <mls@reolight.net>,
       "Jeff Garzik" <jgarzik@pobox.com>,
       "lkml - Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 06 Jun 2004 13:11:22.0645 (UTC) FILETIME=[C3A96450:01C44BC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> 
> Why can't we apply this minimal fix from Yi for now?

Thanks, this is in 2.6.7-rc2-mm2.

> 
> --- linux-2.6.7-rc1-mm1.orig/init/main.c        2004-05-28
> 12:39:15.549314064 +0800 +++ linux-2.6.7-rc1-mm1/init/main.c    
> 2004-05-28 12:40:29.399087192 +0800
> @@ -162,7 +162,7 @@ static int __init obsolete_checksetup(ch        
>         p = &__setup_start; do {
>                 int n = strlen(p->str);
> -               if (len <= n && !strncmp(line, p->str, n)) {
> +               if (n == 0 || (len <= n && !strncmp(line, p->str,
>                         n))) { /* Already done in parse_early_param?
>                         */ if (p->early)
>                                 return 1;
> 

Thanks,
-yi
