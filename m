Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265594AbUBJAG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 19:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbUBJAG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 19:06:28 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:27265 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265389AbUBJACH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 19:02:07 -0500
Date: Mon, 9 Feb 2004 19:02:05 -0500
From: Willem Riede <wrlk@riede.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Selective attach for ide-scsi
Message-ID: <20040210000205.GG28026@serve.riede.org>
Reply-To: wrlk@riede.org
References: <20040208224248.GA28026@serve.riede.org> <16423.17315.777835.128816@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <16423.17315.777835.128816@alkaid.it.uu.se> (from mikpe@csd.uu.se on Mon, Feb 09, 2004 at 03:24:03 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.02.09 03:24, Mikael Pettersson wrote:
> Willem Riede writes:
>  > Today, if you boot 2.6.x with hdd=ide-scsi, ide-scsi will attach to
>  > all your Atapi drives, not just hdd, unless you explicitely specified
>  > another driver for those.
>  > 
>  > Given that we don't want people to use ide-scsi for cdroms and cd-writers,
>  > that behavior is IMHO suboptimal.
>  > 
>  > The patch below makes ide-scsi attach ONLY to those drives that you tell
>  > it to. So if you want it to handle hdb and hdd, but not hdc, you boot
>  > with hdb=ide-scsi hdd=ide-scsi.
> 
> The patch I posted, which you apparently didn't like, doesn't
> require the use of boot-only options: it instead adds a module_param
> to ide-scsi which allows for greater flexibility.
> 
> Personally I never liked that butt-ugly hdX=ide-scsi hack.

I hear you. There are certainly advantages to use a module parameter rather
than a boot argument.

However, there should not be two mechanisms to achieve the same goal. For
better or for worse, the hdX=<driver> construction exists, and people are
using it. Its use is not limited to ide-scsi.

Since it can very easily be adjusted to achieve the desired selectivety,
I believe it is the mechanism of choice. 

Does anyone else have an opinion?

Thanks, Willem Riede.
