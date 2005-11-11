Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbVKKRwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbVKKRwP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 12:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbVKKRwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:52:15 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:64523 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750977AbVKKRwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:52:14 -0500
Message-ID: <4374DA3D.6050704@shadowen.org>
Date: Fri, 11 Nov 2005 17:51:57 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow flatmem to be disabled when only sparsemem is implemented
References: <20051111160341.GK14770@krispykreme>
In-Reply-To: <20051111160341.GK14770@krispykreme>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:

> On architectures that implement sparsemem but not discontigmem we want
> to be able to hide the flatmem option in some cases. On ppc64 for
> example, when we select NUMA we must not select flatmem.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

First reaction is that this is very reasonable.  I can see why you need
to do this as you don't have DISCONTIGMEM.  I will just go check the
major architectures and make sure they arn't relying on being able to
enable SPARSEMEM and getting FLATMEM too behaviour.  I don't think they
can be as they all have DISCONTIGMEM and so should be insulated.

-apw
