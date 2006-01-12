Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWALBk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWALBk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWALBkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:40:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:43433 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964963AbWALBkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:40:55 -0500
From: Andi Kleen <ak@suse.de>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
Date: Thu, 12 Jan 2006 02:40:40 +0100
User-Agent: KMail/1.8.2
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com> <200601120227.45209.ak@suse.de> <ada64oqi63w.fsf@cisco.com>
In-Reply-To: <ada64oqi63w.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120240.41199.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 02:32, Roland Dreier wrote:
>     Andi> Well then they can just as well use normal memcpy as long as
>     Andi> they don't pass any sizes % 4 != 0. That should be ok as
>     Andi> long as they add a comment there.
> 
> But then the driver will be doing memcpy() to I/O memory, which may
> work by chance on x86_64 but will blow up on other archs.

I meant aliasing it to memcpy on x86-64

But with the nasty qword splitup assumptions it would be wrong anyways,
so scratch that.

-Andi
