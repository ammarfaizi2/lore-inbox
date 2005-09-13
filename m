Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVIMC4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVIMC4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 22:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVIMC4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 22:56:12 -0400
Received: from fmr18.intel.com ([134.134.136.17]:18313 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932321AbVIMC4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 22:56:12 -0400
Subject: Re: [PROBLEM] mtrr's not set, 2.6.13
From: Shaohua Li <shaohua.li@intel.com>
To: Jim McCloskey <mcclosk@ucsc.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050912172426.GA2882@branci40>
References: <20050912091021.GA2859@branci40>
	 <20050912025120.4016c36b.akpm@osdl.org>  <20050912172426.GA2882@branci40>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 11:01:27 +0800
Message-Id: <1126580487.4047.1.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 10:24 -0700, Jim McCloskey wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> 
>   |>  In a 2.6.13 tree could you please do
>   |>  
>   |>  wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc2/2.6.13-rc2-mm1/broken-out/mtrr-suspend-resume-cleanup.patch
>   |>  patch -p1 -R < mtrr-suspend-resume-cleanup.patch
>   |>  
>   |>  and retest?
> 
> Thank you very much. Unfortunately, this doesn't seem to have had any
> effect, as far as I can see:
> 
> ----------------------------------------------------------------------
> /proc/mtrr:
> 
> reg00: base=0x00000000 (   0MB), size=983552MB: write-back, count=1
The size isn't sane. Looks like the upper bits of the size mask isn't 1.
Can you track it down what's the value of variable 'size_of_mask' in
mtrr/main.c?

Thanks,
Shaohua

