Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWEZRGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWEZRGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWEZRGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:06:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751163AbWEZRGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:06:30 -0400
Date: Fri, 26 May 2006 10:05:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 14/33] readahead: state based method - data structure
Message-Id: <20060526100552.17edbf90.akpm@osdl.org>
In-Reply-To: <348469542.39504@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469542.39504@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
>  #define RA_FLAG_MISS 0x01	/* a cache miss occured against this file */
>   #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
>  +#define RA_FLAG_MMAP		(1UL<<31)	/* mmaped page access */
>  +#define RA_FLAG_NO_LOOKAHEAD	(1UL<<30)	/* disable look-ahead */
>  +#define RA_FLAG_EOF		(1UL<<29)	/* readahead hits EOF */

Odd.  Why not use 4, 8, 16?
