Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbSI1Nyj>; Sat, 28 Sep 2002 09:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261498AbSI1Nyj>; Sat, 28 Sep 2002 09:54:39 -0400
Received: from pD9E23260.dip.t-dialin.net ([217.226.50.96]:39560 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261490AbSI1Nyj>; Sat, 28 Sep 2002 09:54:39 -0400
Date: Sat, 28 Sep 2002 08:00:33 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Christoph Hellwig <hch@infradead.org>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Tomas Szepe <szepe@pinerecords.com>, Zach Brown <zab@zaboo.net>
Subject: Re: [PATCH][2.5] Single linked headed lists for Linux, v3
In-Reply-To: <20020928144722.A356@infradead.org>
Message-ID: <Pine.LNX.4.44.0209280757070.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 28 Sep 2002, Christoph Hellwig wrote:
> All of those are utter crap.  Older gcc's had some little inlining
> problems that generated suboptimal code, but that's cured now and I
> don't thikn it even made a difference for the small list_* functions.

I think if we scale slists to be like lists, we don't need to make the 
difference at all. slists are supposed to be lightweight lists, single 
direction, and working anywhere on any type of structure. (e.g. you can 
access a whole struct thread through the ->next pointer, instead of 
further crap.)

If we can avoid type dependency, we should do now. If you want inlined 
code, go read list.h. (I remember that's why the lists were called 
`type-safe', BTW. Meant to be type-preserve, and definitely the same type 
as before.)

			Thunder
-- 

