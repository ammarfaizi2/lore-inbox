Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263481AbTDVUVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTDVUVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:21:12 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:65185 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263481AbTDVUVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:21:11 -0400
Date: Tue, 22 Apr 2003 16:29:36 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH][ANNOUNCE] Linux 2.5.68-ce2
To: Jvrn Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304221632_MC3-1-358B-4DE7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jvrn Engel wrote:


> How about the following?
> 
> +#include <linux/cache.h>
> +#define CACHELINE_ALIGN .align L1_CACHE_BYTES,0x90
> ...
> -	ALIGN
>+	CACHELINE_ALIGN
> ...
>
> Or was this a bad guess of what you wanted to do?


  With 32-byte cachelines it woulf probably be too much wasted
space -- the handlers are only 10 bytes long at worst and some of
them are only 7 bytes.  Maybe packing three of them per cacheline might
work better in that case?


-------
 Chuck
