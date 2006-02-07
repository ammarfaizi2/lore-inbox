Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWBGX1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWBGX1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWBGX1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:27:41 -0500
Received: from amdext4.amd.com ([163.181.251.6]:8326 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1030261AbWBGX1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:27:40 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Christoph Lameter" <clameter@engr.sgi.com>
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes
 2.6.16-rc1[2] on 2 node X86_64
Date: Tue, 7 Feb 2006 17:27:17 -0600
User-Agent: KMail/1.8
cc: "Bharata B Rao" <bharata@in.ibm.com>, "Andi Kleen" <ak@suse.de>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <20060205163618.GB21972@in.ibm.com>
 <20060207055955.GB18917@in.ibm.com>
 <Pine.LNX.4.62.0602070848450.24487@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602070848450.24487@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Message-ID: <200602071727.18359.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 07 Feb 2006 23:27:19.0496 (UTC)
 FILETIME=[0A0E9480:01C62C3E]
X-WSS-ID: 6FF7F35D0BO3626235-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 10:49, Christoph Lameter wrote:
> On Tue, 7 Feb 2006, Bharata B Rao wrote:
> > I can still crash my x86_64 box with Christoph's program.
>
> So it looks like the problem is arch specific. Test program runs fine on
> ia64.
>
> > page = 0xffffffffffffffd8
> > &page->lru = 0000000000000000
>
> Yup lru field overwritten as I thought.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

For what it is worth:

Christoph's test program runs fine on my 32 GB, 4 socket, 8 core Opteron 64 
box with 2.6.16-rc1.
-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

