Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWAXAqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWAXAqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWAXAqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:46:35 -0500
Received: from amdext4.amd.com ([163.181.251.6]:6110 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1030248AbWAXAqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:46:34 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Dave McCracken" <dmccr@us.ibm.com>
Subject: Re: [PATCH/RFC] Shared page tables
Date: Mon, 23 Jan 2006 18:46:07 -0600
User-Agent: KMail/1.8
cc: "Robin Holt" <holt@sgi.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <200601231758.08397.raybry@mpdtxmail.amd.com>
 <6BC41571790505903C7D3CD6@[10.1.1.4]>
In-Reply-To: <6BC41571790505903C7D3CD6@[10.1.1.4]>
MIME-Version: 1.0
Message-ID: <200601231846.08594.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 24 Jan 2006 00:46:10.0071 (UTC)
 FILETIME=[9180CA70:01C6207F]
X-WSS-ID: 6FCBA7580MS268231-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 18:19, Dave McCracken wrote:
<snip>
>
> The basic rule for pte sharing is that some portion of a memory region must
> span an entire pte page.  For i386 and x96_64 that would be 2 meg.  The
> region must either be read-only or marked to be shared if it is writeable.
>

Yeah, I figured that out just after hitting "send" on that first note.  :-(

> The code does opportunistically look for any pte page that is fully within
> a shareable vma, and will share if it finds one.
>
> Oh, and one more caveat.  The region must be mapped to the same address in
> each process.
>
> > I turned on the PT_DEBUG stuff, but thus far have found no evidence of
> > pte  sharing actually occurring in a normal system boot.  I'm surprised
> > by that as  I (naively?) would have expected shared libraries to use
> > shared ptes.
>

OK, with those guidelines I can put together a test program pretty quickly.
If you have one handy that would be fine, but don't put a lot of effort into 
it.

Thanks,

> Most system software, including the shared libraries, don't have any
> regions that are big enough for sharing (the text section for libc, for
> example, is about 1.5 meg).
>

Ah, that explains that then.

> Dave McCracken

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

