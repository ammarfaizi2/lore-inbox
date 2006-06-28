Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWF1Fwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWF1Fwz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWF1Fwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:52:55 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:9174 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964807AbWF1Fwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:52:54 -0400
Date: Wed, 28 Jun 2006 09:49:45 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [RFC][PATCH 0/3] Process events biarch bug: Intro
Message-ID: <20060628054945.GA12276@2ka.mipt.ru>
References: <1151408822.21787.1807.camel@stark> <20060627123325.GA26716@2ka.mipt.ru> <1151444391.21787.1860.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1151444391.21787.1860.camel@stark>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 28 Jun 2006 09:49:48 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 02:39:51PM -0700, Matt Helsley (matthltc@us.ibm.com) wrote:
> > Btw, __u64 is not the best choice for some arches too due to it's
> > alignment (64bit code requires u64 to be aligned to 64 bit, while 32bit
> > code will only align it to 32 bits), so you will need 
> > attribute ((aligned(8)))) for your own ___u64.
> 
> 	Fixing the alignment would be a good idea. Though setting it to 8 would
> introduce 4 unused bytes at the end of the structure.

Otherwise your code will not work, although u64 is supposed to be fixed
size, due to it's alignment problems it can not be used as is.
Split timestamp into two 32bit values and everything will be ok.

> Cheers,
> 	-Matt Helsley

-- 
	Evgeniy Polyakov
