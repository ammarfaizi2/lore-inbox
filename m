Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263344AbTC0Rdo>; Thu, 27 Mar 2003 12:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263345AbTC0Rdo>; Thu, 27 Mar 2003 12:33:44 -0500
Received: from [81.2.110.254] ([81.2.110.254]:57334 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263344AbTC0Rdm>;
	Thu, 27 Mar 2003 12:33:42 -0500
Subject: Re: wonderffffffffull ac filemap patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303271656270.2483-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303271656270.2483-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048787156.3229.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 27 Mar 2003 17:45:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 17:33, Hugh Dickins wrote:
> Here's a patch I've stolen from 2.4-ac, which is clearly correct so
> far as it goes.  I keep wanting to get this integrated into 2.4 and
> 2.5, then bring shmem.c into line (in 2.5 use generic_write_checks).
> 
> But each time I approach it, I get stuck on trying to understand the
> code it's a good patch to.  I understand that there's a problem with
> loff_t twice as wide as rlim, and that we need to trim count down near
> the limit.  But I don't understand why 0xFFFFFFFFULL and (u32) rather
> than RLIM_INFINITY and (unsigned long): are we really trying to
> cripple 64-bit arches here?

For 2.4 I just wanted to handle what we had and fix up the spec violations.
For 2.5.x rlimit64 is calling 8)

