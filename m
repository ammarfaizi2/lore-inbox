Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287804AbSA2AEH>; Mon, 28 Jan 2002 19:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287794AbSA2AD5>; Mon, 28 Jan 2002 19:03:57 -0500
Received: from mail205.mail.bellsouth.net ([205.152.58.145]:13657 "EHLO
	imf05bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S287804AbSA2ADl>; Mon, 28 Jan 2002 19:03:41 -0500
Subject: Re: Rik van Riel's vm-rmap
From: Louis Garcia <louisg00@bellsouth.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0201280613510.32617-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201280613510.32617-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 (1.0.1-2) 
Date: 28 Jan 2002 19:07:06 -0500
Message-Id: <1012262826.1634.1.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this patch work well with Andrew's low-latency patch?

--Louis


On Mon, 2002-01-28 at 03:21, Rik van Riel wrote:
> On 27 Jan 2002, Louis Garcia wrote:
> 
> > Does he still use classzones as the basis for the vm? I thought that
> > linux was trying to get away from classzones for better NUMA support in
> > 2.5??
> 
> Nope.  I've done a few modifications:
> 
> 1) the IMHO inflexible classzone stuff has been removed
> 
> 2) we have reverse mappings, so we can do our pageout
>    scan by physical address
> 
> 3) this in turn means the active, inactive_dirty and
>    inactive_clean lists are per zone ... allowing us
>    to scan only in those zones where we actually need
>    to free pages
> 
> regards,
> 
> Rik
> -- 
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 



