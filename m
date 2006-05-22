Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWEVLSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWEVLSZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWEVLSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:18:25 -0400
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:33489 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750750AbWEVLSY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:18:24 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure.
Date: Mon, 22 May 2006 21:17:26 +1000
User-Agent: KMail/1.9.1
Cc: Haar =?iso-8859-1?q?J=E1nos?= <djani22@netcenter.hu>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>, cw@f00f.org
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <44710144.7090105@yahoo.com.au> <00d201c67d73$220d5d10$1800a8c0@dcccs>
In-Reply-To: <00d201c67d73$220d5d10$1800a8c0@dcccs>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605222117.27433.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 17:41, Haar János wrote:
> ----- Original Message -----
> From: "Nick Piggin" <nickpiggin@yahoo.com.au>
> > Yeah, as I said, block device's pagecache (aka buffercache) can't
> > use highmem. If nbd can export regular files as block devices, or
> > you use loop devices from regular files, that might help (or slow
> > things down :P).
>
> Hmm.
> That sounds bad.
> I think, if highmem is unreachable some times that makes lowmem more
> valuable!
> The kernel needs to keep (reserve) it free as much as possible.
> The buffer-cache is an unimportant thing next to keeping lowmem free, but
> it is blocks the performance and wastes the systems resources!
>
> It is possible any workaround?

Try with one of the alternative vmsplit options that gives you more lowmem? 
That might break certain applications though.

-- 
-ck
