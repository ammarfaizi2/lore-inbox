Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263248AbUCNCT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 21:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263253AbUCNCT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 21:19:58 -0500
Received: from terminus.zytor.com ([63.209.29.3]:63126 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263248AbUCNCT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 21:19:57 -0500
Message-ID: <4053C08D.2050703@zytor.com>
Date: Sat, 13 Mar 2004 18:16:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 very early memory detection cleanup patch breaks the build
References: <1079198139.2512.19.camel@mulgrave>		<40538091.9050707@zytor.com> <1079215809.2513.39.camel@mulgrave> 	<40538B39.90803@zytor.com> <1079229921.2074.65.camel@mulgrave>
In-Reply-To: <1079229921.2074.65.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> OK, I found it, it was a swapper_pg_dir replacement assumption that
> breaks if pg0 isn't in the known location.  Voyager still does odd
> tricks with this because it also has a 486 SMP configuration (which I've
> yet to test still boots...).

Ick.  Hard-coded address error.

> The attached patch fixes everything for me (do we agree on the
> trampoline thing as the final form?)

It's a bit ugly, but good enough for me.

Andrew, I think this patch should go in.

Thanks,

	-hpa
