Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWAXARA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWAXARA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWAXARA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:17:00 -0500
Received: from amdext4.amd.com ([163.181.251.6]:11482 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932454AbWAXAQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:16:59 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Dave McCracken" <dmccr@us.ibm.com>
Subject: Re: [PATCH/RFC] Shared page tables
Date: Mon, 23 Jan 2006 18:16:38 -0600
User-Agent: KMail/1.8
cc: "Robin Holt" <holt@sgi.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
 <20060117235302.GA22451@lnx-holt.americas.sgi.com>
 <200601231758.08397.raybry@mpdtxmail.amd.com>
In-Reply-To: <200601231758.08397.raybry@mpdtxmail.amd.com>
MIME-Version: 1.0
Message-ID: <200601231816.38942.raybry@mpdtxmail.amd.com>
X-OriginalArrivalTime: 24 Jan 2006 00:16:40.0298 (UTC)
 FILETIME=[72A2DCA0:01C6207B]
X-WSS-ID: 6FCBAE620BO268940-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 17:58, Ray Bryant wrote:
<snip>

> ... And what kind of alignment constraints do we end up
> under in order to make the sharing happen?   (My guess would be that there
> aren't any such constraints (well, page alignment.. :-)  if we are just
> sharing pte's.)
>

Oh, obviously that is not right as you have to share full pte pages.   So on 
x86_64 I'm guessing one needs 2MB alignment in order to get the sharing to
kick in, since a pte page maps 512 pages of 4 KB each.

Best Regards,
-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

