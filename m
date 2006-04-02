Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWDBIvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWDBIvw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 04:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWDBIvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 04:51:52 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:9636 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932149AbWDBIvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 04:51:51 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.16-ck3
Date: Sun, 2 Apr 2006 18:51:39 +1000
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200604021401.13331.kernel@kolivas.org> <442F5721.2040906@yahoo.com.au>
In-Reply-To: <442F5721.2040906@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604021851.39763.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 April 2006 14:46, Nick Piggin wrote:
> The swap prefetching here, and the one in -mm AFAIKS still do not follow
> the lowmem reserve ratio correctly. This might explain why prefetching
> appears to help some people after updatedb swaps stuff out to make room
> for pagecache -- it may actually be dipping into lower zones when it
> shouldn't.

Curious. I was under the impression lowmem reserve only did anything if you 
manually set it, and the users reporting on swap prefetch behaviour are not 
the sort of users likely to do so. I'm happy to fix whatever the lowmem 
reserve bug is but I doubt this bug is making swap prefetch behave better for 
ordinary users. Well, whatever the case is I'll have another look at lowmem 
reserve of course. 

Cheers,
Con
