Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313828AbSDIJNR>; Tue, 9 Apr 2002 05:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313831AbSDIJNQ>; Tue, 9 Apr 2002 05:13:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48388 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313828AbSDIJNP>;
	Tue, 9 Apr 2002 05:13:15 -0400
Message-ID: <3CB2B09C.DF1A0AC2@zip.com.au>
Date: Tue, 09 Apr 2002 02:13:00 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrey Nekrasov <andy@spylog.ru>
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.4.19-pre6aa1
In-Reply-To: <20020409084335.GA10890@spylog.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Nekrasov wrote:
> 
> ..
> >>EIP; e0115c1c <out_of_line_bug+0/14>   <=====
> Trace; e012069a <copy_page_range+1da/334>
> Trace; e0114caa <copy_mm+222/2bc>
> Trace; e01154b6 <do_fork+42e/744>
> Trace; e0107270 <sys_fork+14/1c>

hmm.  That out-of-line stuff has obfuscated the trace
a bit.  It died in kunmap_atomic or kmap_atomic, part
of Andrea's pte-highmem additions.

I guess the out-of-line bug should be if !CONFIG_DEBUG_KERNEL.

-
