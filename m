Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVLCCDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVLCCDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 21:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVLCCDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 21:03:44 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:5521 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751151AbVLCCDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 21:03:44 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for  benchmarks
To: Andrew Morton <akpm@osdl.org>, Dirk Henning Gerdes <mail@dirk-gerdes.de>,
       axboe@suse.de, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 03 Dec 2005 03:05:34 +0100
References: <5f08L-Um-413@gated-at.bofh.it> <5f7UE-3FH-13@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EiMmN-0001a6-I7@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> +             .procname       = "drop-pagecache",
> +             .data           = NULL,
> +             .maxlen         = sizeof(int),
> +             .mode           = 0644,

1) Shouldn't this be a trigger? Reading from a trigger doesn't make sense,
   especially when triggering on a read.  .mode = 0200?


2) If you pass an int, wouldn't a bitmask selecting what to free make sense?
   (off cause -1 == everything)
   Maybe this would be overengineered.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
