Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbUKMWJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbUKMWJf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 17:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbUKMWJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 17:09:35 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:27959 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261182AbUKMWJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 17:09:32 -0500
Date: Sat, 13 Nov 2004 23:09:18 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1-bk21] [m32r] Update defconfig files
Message-ID: <20041113220918.GD8319@mars.ravnborg.org>
Mail-Followup-To: Hirokazu Takata <takata@linux-m32r.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20041112.173414.28782636.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041112.173414.28782636.takata.hirokazu@renesas.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 05:34:14PM +0900, Hirokazu Takata wrote:
> Hello,
> 
> This patch is for updating defconfig files for m32r.
> All defconfig files are regenerated for 2.6.10-rc1-bk21.
> 
> Thanks.
> 
> Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
> ---
> 
>  arch/m32r/defconfig                       |  152 +++++-
>  arch/m32r/m32700ut/defconfig.m32700ut.smp |  130 ++++-
>  arch/m32r/m32700ut/defconfig.m32700ut.up  |  130 ++++-
>  arch/m32r/mappi/defconfig.nommu           |  109 +++-
>  arch/m32r/mappi/defconfig.smp             |  104 +++-
>  arch/m32r/mappi/defconfig.up              |  104 +++-
>  arch/m32r/mappi2/defconfig.vdec2          |  698 ++++++++++++++++++++++++++++++
>  arch/m32r/oaks32r/defconfig.nommu         |   93 +++
>  arch/m32r/opsput/defconfig.opsput         |  114 +++-
>  9 files changed, 1424 insertions(+), 210 deletions(-)
Any reason why you do not place them in arch/m32r/configs like ppc and arm?
If you name them like arm/ppc then you play like the rest of the archs.
As an added bonus the config options shows up in "make help".

You should also consider using the newly introduced KBUILD_DEFCONFIG.
Let it point to the most 'popular' of the arch/m32r/configs/defconfig* files
then you do not need the file arch/m32r/defconfig.

	Sam
