Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbSJMMOA>; Sun, 13 Oct 2002 08:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261507AbSJMMOA>; Sun, 13 Oct 2002 08:14:00 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:40516 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S261505AbSJMMN7>;
	Sun, 13 Oct 2002 08:13:59 -0400
Date: Sun, 13 Oct 2002 14:19:45 +0200 (CEST)
From: Witek Krecicki <adasi@kernel.pl>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is initrd working?
In-Reply-To: <20021013043121.A1300@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44L.0210131418440.8712-100000@ep09.kernel.pl>
References: <20021013043121.A1300@adam.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Adam J. Richter wrote:

> Date: Sun, 13 Oct 2002 04:31:21 -0700
> From: Adam J. Richter <adam@yggdrasil.com>
> To: adasi@kernel.pl
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Is initrd working?
> 
> On 2002-10-13 at 9:45:38, Witek Krecicki wrote:
> >I was trying to run initrd on 2.5.41, 2.5.42, 2.5.42-mm{1,2}, 2.5.42-ac1 
> >and it is not working in any case (oopsing just after RAMDISK: Compressed 
> >image found...). I've sent decoded oops some time ago, without any 
> >response. I cannot even try modular IDE because of that :/
> >Please help
> 
> 	Make sure you are not running CONFIG_HIGHMEM64G.  I believe there
> is some kind of memory corruption problem under highmem=64g on x86 with
> big ramdisks.  I use a ~900kB initial ramdisk that expands to ~2.2MB.
> 
> 	With CONFIG_HIGHMEM4G or CONFIG_NOHIGHMEM, the problem disappears
> for me.  I am writing this email under 2.5.41 with CONFIG_HIGHMEM4G and
> IDE as a module (with a patch that I posted to lkml).
I've checked this config option:  CONFIG_HIGHMEM4G was enabled. I've 
turned it to NOHIGHMEM, recompiled and it's still not working. ramdisk is 
pretty small (just IDE)
WK

