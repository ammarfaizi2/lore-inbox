Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbSI1NmC>; Sat, 28 Sep 2002 09:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbSI1NmC>; Sat, 28 Sep 2002 09:42:02 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:30734 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261400AbSI1NmB>; Sat, 28 Sep 2002 09:42:01 -0400
Date: Sat, 28 Sep 2002 14:47:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Tomas Szepe <szepe@pinerecords.com>, Zach Brown <zab@zaboo.net>
Subject: Re: [PATCH][2.5] Single linked headed lists for Linux, v3
Message-ID: <20020928144722.A356@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Thunder from the hill <thunder@lightweight.ods.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Tomas Szepe <szepe@pinerecords.com>, Zach Brown <zab@zaboo.net>
References: <20020928143058.A32459@infradead.org> <Pine.LNX.4.44.0209280743490.7827-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209280743490.7827-100000@hawkeye.luckynet.adm>; from thunder@lightweight.ods.org on Sat, Sep 28, 2002 at 07:45:00AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 07:45:00AM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Sat, 28 Sep 2002, Christoph Hellwig wrote:
> > On Sat, Sep 28, 2002 at 07:27:37AM -0600, Thunder from the hill wrote:
> > > Sorry, inline taints the concept. It's supposed to work with any type. 
> > > (This time.) We've had crappy times with list.h, so slist.h shall not use 
> > > inlines.
> > 
> > Define crappy times.
> 
>  - casts
>  - list members had to be in some specified place of the struct
>  - some binary disadvantages

All of those are utter crap.  Older gcc's had some little inlining
problems that generated suboptimal code, but that's cured now and
I don't thikn it even made a difference for the small list_* functions.
