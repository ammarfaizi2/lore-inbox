Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbTEOAdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbTEOAdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:33:45 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:40380 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263202AbTEOAdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:33:44 -0400
Date: Wed, 14 May 2003 17:41:58 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: ch@murgatroid.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
Message-Id: <20030514174158.47c2a3b5.akpm@digeo.com>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780CCB0A70@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780CCB0A70@orsmsx116.jf.intel.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 00:46:29.0000 (UTC) FILETIME=[6BE56080:01C31A7B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com> wrote:
>
> How does this affect mm_release() in fork.c? there is a call to sys_futex();
> if you make it conditional, will it break anything in there?

Via linker magic, mm_release() will simply call sys_ni_syscall() instead.  

(I ran a futex-free ppc64 kernel.  It worked.)
