Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWGVXFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWGVXFI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 19:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWGVXFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 19:05:08 -0400
Received: from main.gmane.org ([80.91.229.2]:33693 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751070AbWGVXFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 19:05:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: larsbj@gullik.net (=?iso-8859-1?q?Lars_Gullik_Bj=F8nnes?=)
Subject: Re: [RFC][PATCH] A generic boolean (version 3)
Date: 22 Jul 2006 11:55:02 +0200
Organization: LyX Developer http://www.lyx.org/
Message-ID: <m3mzb2c6bt.fsf@tyfon.gullik.net>
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153524422.44c162c65c21b@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm-84.208.245.227.chello.no
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ricknu-0@student.ltu.se writes:

| --- a/include/asm-i386/types.h
| +++ b/include/asm-i386/types.h
| @@ -1,6 +1,13 @@
|  #ifndef _I386_TYPES_H
|  #define _I386_TYPES_H
|  
| +#if __GNUC__ >= 3
| +typedef _Bool bool;
| +#else
| +#warning You compiler doesn't seem to support boolean types, will set 'bool' as
| an 'unsigned int'
| +typedef unsigned int bool;
| +#endif
| +

What does C99 say about sizeof(_Bool)?

At least with gcc 4 it is 1. Can that pose a problem? gcc < 3 giving a
different size for bool?

-- 
	Lgb

