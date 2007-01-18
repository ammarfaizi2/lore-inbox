Return-Path: <linux-kernel-owner+w=401wt.eu-S932526AbXARQsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbXARQsz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 11:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbXARQsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 11:48:55 -0500
Received: from [139.30.44.16] ([139.30.44.16]:6731 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932526AbXARQsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 11:48:54 -0500
Date: Thu, 18 Jan 2007 17:48:53 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH]  Centralize the macro definition of "__packed".
In-Reply-To: <Pine.LNX.4.64.0701180959470.19826@CPE00045a9c397f-CM001225dbafb6>
Message-ID: <Pine.LNX.4.63.0701181745550.2068@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.64.0701180959470.19826@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007, Robert P. J. Day wrote:

>   Centralize the attribute macro definition of "__packed" so no
> subsystem has to do that explicitly.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
>   compile tested to make sure the HFS subsystem still builds.  now
> there's just 50 gazillion usages of "__attribute__((packed))" that can
> be tightened up.
> 
> 
>  fs/hfs/hfs.h                 |    2 --
>  fs/hfsplus/hfsplus_raw.h     |    2 --
>  include/linux/compiler-gcc.h |    1 +
>  3 files changed, 1 insertion(+), 4 deletions(-)

Moving definitions into compiler-gcc.h only will screw non-gcc compilers 
like icc.
They should probably go into the generic section of compiler.h instead.

Tim
