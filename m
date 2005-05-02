Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVEBRTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVEBRTA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVEBRQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:16:30 -0400
Received: from colin.muc.de ([193.149.48.1]:18951 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261218AbVEBRPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:15:54 -0400
Date: 2 May 2005 19:15:51 +0200
Date: Mon, 2 May 2005 19:15:51 +0200
From: Andi Kleen <ak@muc.de>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Guo, Racing" <racing.guo@intel.com>, Andrew Morton <akpm@osdl.org>,
       "Yu, Luming" <luming.yu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]porting lockless mce from x86_64 to i386
Message-ID: <20050502171551.GG27150@muc.de>
References: <88056F38E9E48644A0F562A38C64FB60049EED02@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60049EED02@scsmsx403.amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 09:15:07AM -0700, Pallipadi, Venkatesh wrote:
> >-----Original Message-----
> >From: linux-kernel-owner@vger.kernel.org 
> >[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Guo, Racing
> >Sent: Sunday, May 01, 2005 6:02 PM
> >To: Andi Kleen; Andrew Morton
> >Cc: Yu, Luming; linux-kernel@vger.kernel.org
> >Subject: RE: [PATCH]porting lockless mce from x86_64 to i386
> >
> >>
> >>If Luming would not move the mce.c file from x86-64 to i386 then
> >>his patch would be only 1/4 as big. I dont know why he does this
> >>anyways, it seems completely pointless.
> >
> >mce.c mce.h and mce_intel.c are moved from x86_64 to i386. so the
> >patch is very big. The motivation is to share mce code between
> >x86_64 and i386 and avoid duplicate code in x86_64 and i386.
> >I don't know whether I completely understand what you point.
> >Correct me if I am wrong.
> 
> I think what Andi meant was that instead of copying code from x86-64 
> to i386 and making x86-64 link to this i386 copy, you can leave the 
> code in x86-64 and link it from i386 part of the tree. 

Yep.

> 
> Doing it either way should be OK with this mce code. But I feel, 
> despite of the patch size, it is better to keep all the shared 
> code in i386 tree and link it from x86-64. Otherwise, it may become 
> kind of messy in future, with various links between i386 and x86-64.

i386 already uses code from x86-64 (earlyprintk.c) - it is nothing 
new.


-Andi
