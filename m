Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVBZXLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVBZXLl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 18:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVBZXLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 18:11:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:59590 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261287AbVBZXLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 18:11:39 -0500
Date: Sat, 26 Feb 2005 15:12:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
In-Reply-To: <20050226225203.GA25217@apps.cwi.nl>
Message-ID: <Pine.LNX.4.58.0502261510030.25732@ppc970.osdl.org>
References: <20050226213459.GA21137@apps.cwi.nl>
 <16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de>
 <Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org> <20050226225203.GA25217@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Feb 2005, Andries Brouwer wrote:
> 
> The default fdisk will assign type 83 to a newly created partition.

Ok. Is that a "it has done so for the last 5 years" thing? 

> (About type 0: DOS has used type 0 as definition of unused. It is not
> bad if Linux uses DOS-conventions for a DOS-type partition table.)

Agreed. At the same time, I could well imagine that some people might use 
such a type exactly to make DOS ignore it (but I assume the same is true 
of the regular 0x83 type too, so maybe I'm just being difficult).

There's certainly a good argument for fixing a known problem (Uwe) and a 
small enough risk of it breaking anything else.

		Linus
