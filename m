Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319243AbSH2Pfj>; Thu, 29 Aug 2002 11:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319249AbSH2Pfi>; Thu, 29 Aug 2002 11:35:38 -0400
Received: from pD9E2399E.dip.t-dialin.net ([217.226.57.158]:49095 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319243AbSH2Pfi>; Thu, 29 Aug 2002 11:35:38 -0400
Date: Thu, 29 Aug 2002 09:39:14 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Rusty Russell <rusty@rustcorp.com.au>
cc: junio@siamese.dyndns.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1)
In-Reply-To: <20020828221716.1A73C2C09E@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0208290938180.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 29 Aug 2002, Rusty Russell wrote:
> If you really care about that, try:
> 
> 	/* Be paranoid in case someone uses strlen(&("FOO"[0])) */
> 	#define strlen(x) \
> 		(__builtin_constant_p(x) && sizeof(x) != sizeof(char *)
> 		? (sizeof(x) - 1) : __strlen(x))

I must say that doesn't make the code any cleaner, which leads to it being 
not as clean as Keith suggested. It was a code cleanup, not a code messup.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

