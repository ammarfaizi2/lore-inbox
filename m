Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSGQU1J>; Wed, 17 Jul 2002 16:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316668AbSGQU1J>; Wed, 17 Jul 2002 16:27:09 -0400
Received: from mailrelay.ds.lanl.gov ([128.165.47.40]:50845 "EHLO
	mailrelay.ds.lanl.gov") by vger.kernel.org with ESMTP
	id <S316667AbSGQU1J>; Wed, 17 Jul 2002 16:27:09 -0400
Subject: Re: 2.5.25-dj2, kernel BUG at dcache.c:361
From: Steven Cole <elenstev@mesatop.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       Steven Cole <scole@lanl.gov>
In-Reply-To: <20020717221640.D32389@suse.de>
References: <1026936410.11636.107.camel@spc9.esa.lanl.gov> 
	<20020717221640.D32389@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 17 Jul 2002 14:26:59 -0600
Message-Id: <1026937620.11339.118.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 14:16, Dave Jones wrote:
> On Wed, Jul 17, 2002 at 02:06:50PM -0600, Steven Cole wrote:
>  > While running 2.5.25-dj2 and dbench with increasing numbers of clients,
>  > my test machine locked up with the following message:
>  > 
>  > kernel BUG at dcache.c:361!
> 
> There are some -dj specific hacks to dcache.c to convert to use
> list_t types. Which from memory, I think William Lee Irwin did.
> (wli, can you double check those just in case there's either an
>  obvious thinko, or a mismerge if you get time ?)
> 
> Failing that, this could be something that also affects mainline
> I think.

I didn't explicitly mention it, but I have successfully run recent
kernels (2.5.2[4,5,6]) with and without the rmap patches with up to 64
dbench clients with no problems observed.  Also 2.4.19-rc[1,2] works
well.  2.5.25-dj2 is the only kernel which has had this dcache.c BUG.
I didn't test 2.5.25-dj1.

Steven

