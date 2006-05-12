Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWELGrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWELGrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWELGrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:47:25 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:56276 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751012AbWELGrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:47:24 -0400
Date: Fri, 12 May 2006 10:47:11 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Brice Goglin <brice@myri.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>, netdev@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>
Subject: Re: [PATCH 4/6] myri10ge - First half of the driver
Message-ID: <20060512064710.GA27065@2ka.mipt.ru>
References: <446259A0.8050504@myri.com> <Pine.GSO.4.44.0605101438410.498-100000@adel.myri.com> <20060510231347.GC25334@electric-eye.fr.zoreil.com> <4463CE88.20301@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <4463CE88.20301@myri.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 12 May 2006 10:47:12 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 01:53:44AM +0200, Brice Goglin (brice@myri.com) wrote:
> > Imho you will want to work directly with pages shortly.
> >   
> 
> We had thought about doing this, but were a little nervous since we did
> not know of any other drivers that worked directly with pages.  If this
> is an official direction to work directly with pages, we will. 

s2io does. e1000 does it with skb frags.
If your hardware allows header split and driver can put headers into
skb->data and real data into frag_list, that allows to create various
interesting things like receiving zero-copy support and netchannels
support. It is work in progress, not official direction currently,
but this definitely will help your driver to support future high 
performance extensions.

> Brice

-- 
	Evgeniy Polyakov
