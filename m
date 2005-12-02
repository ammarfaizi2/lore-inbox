Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbVLBUr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVLBUr7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 15:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbVLBUr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 15:47:59 -0500
Received: from silver.veritas.com ([143.127.12.111]:25719 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750816AbVLBUr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 15:47:58 -0500
Date: Fri, 2 Dec 2005 20:47:45 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Ryan Richter <ryan@tau.solarneutrino.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <Pine.LNX.4.63.0512022131440.4506@kai.makisara.local>
Message-ID: <Pine.LNX.4.61.0512022041130.6058@goblin.wat.veritas.com>
References: <20051129092432.0f5742f0.akpm@osdl.org> 
 <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local> 
 <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <1133468882.5232.14.camel@mulgrave>
 <Pine.LNX.4.63.0512012304240.5777@kai.makisara.local>
 <Pine.LNX.4.61.0512021325020.1507@goblin.wat.veritas.com>
 <Pine.LNX.4.63.0512021932590.4506@kai.makisara.local>
 <Pine.LNX.4.61.0512021836100.4940@goblin.wat.veritas.com>
 <Pine.LNX.4.63.0512022131440.4506@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Dec 2005 20:47:46.0698 (UTC) FILETIME=[A68C46A0:01C5F781]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2005, Kai Makisara wrote:
> On Fri, 2 Dec 2005, Hugh Dickins wrote:
> 
> > It's just that after seeing how sg.c is claiming to dirty even readonly
> > memory, I'm excessively averse to saying we've dirtied memory we haven't.
> > My hangup, I'll get over it!
> > 
> Please don't. I have a very conservative attitude to these things: my 
> priority is to make sure that the data is correct even if it is not the 
> fastest code. I will happily let others point out when I am too 
> conservative.

I'm not certain which way you're directing me now: a conservative
attitude suggests we play safe at the end of st_read, by saying we might
somehow have dirtied memory there, perhaps if someone changes sequence.

As I presently, incompletely have it, to maintain more similarity with
sg.c, I've actually moved away from "dirtied" to "rw" READ or WRITE,
and it will look odd to put WRITE at the end of st_read.

I'm giving up for the evening, and probably won't have a chance to do
more until Sunday - the PageCompound issue still under discussion too.

Hugh
