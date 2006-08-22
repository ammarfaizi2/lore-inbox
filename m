Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWHVAPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWHVAPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWHVAPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:15:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:48256 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750886AbWHVAPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:15:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QNEpe3YSbMEQebSZWR0xeZPoRysvnNmQc4S+i1hdSaxXbDycBAA5Daq9uZEiZ2PpCoC2wA74zAsw0/isZIcgR3Qhq3kv2gb2g9qXeIGK32MK0+jfKEiVoSryAsEAQbHuvbVpynRxzsozt1oz8F8MdS7EYOvaeIvFMvEWl9qCMuw=
Message-ID: <21d7e9970608211715s1953412al1ada86cfa3e25d78@mail.gmail.com>
Date: Tue, 22 Aug 2006 10:15:20 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Eric Sesterhenn" <snakebyte@gmx.de>
Subject: Re: [PATCH] Signdness issue in drivers/video/intelfb/intelfbdrv.c
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <1156100625.3687.6.camel@alice>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1156100625.3687.6.camel@alice>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/06, Eric Sesterhenn <snakebyte@gmx.de> wrote:
> hi,
>
> another gcc 4.1 signess warning:
>
> drivers/video/intelfb/intelfbdrv.c:419: warning: comparison of unsigned expression < 0 is always false
>
> since dinfo->mtrr_reg is of the type u32, the error check dinfo->mtrr_reg < 0
> is useless. This patch introduces a helper variable, which catches possible
> negative error values returned by mtrr_add()
>
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
>

NAK.
I've applied a much simpler fix to use make mtrr_reg an int to my
intelfb tree....

Dave.
