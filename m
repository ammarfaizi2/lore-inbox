Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267652AbUHELwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267652AbUHELwe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUHELwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:52:32 -0400
Received: from colin2.muc.de ([193.149.48.15]:11283 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S267651AbUHELtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:49:22 -0400
Date: 5 Aug 2004 13:49:17 +0200
Date: Thu, 5 Aug 2004 13:49:17 +0200
From: Andi Kleen <ak@muc.de>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: davem@redhat.com, jgarzik@pobox.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-ID: <20040805114917.GC31944@muc.de>
References: <20040804191850.GA19224@havoc.gtf.org> <20040804122254.3d52c2d4.davem@redhat.com> <20040804232116.GA30152@muc.de> <20040804.165113.06226042.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040804.165113.06226042.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, 32bit ipsec on x86-64/ia64 is a NOP because of that.
> 
> Hmm, I don't get the point.
> What part (or which structore) is broken?

xfrm_usersa_info due to inclusion of xfrm_lifetime_cfg/xfrm_lifetime_cur
The xfrm layer uses it like an array, but they have different sizes
on x86-64 and i386.

-Andi
