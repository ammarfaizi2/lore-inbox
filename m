Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSJMLZk>; Sun, 13 Oct 2002 07:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261497AbSJMLZk>; Sun, 13 Oct 2002 07:25:40 -0400
Received: from h-66-167-78-17.SNVACAID.covad.net ([66.167.78.17]:57547 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261495AbSJMLZi>; Sun, 13 Oct 2002 07:25:38 -0400
Date: Sun, 13 Oct 2002 04:31:21 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: adasi@kernel.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is initrd working?
Message-ID: <20021013043121.A1300@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-13 at 9:45:38, Witek Krecicki wrote:
>I was trying to run initrd on 2.5.41, 2.5.42, 2.5.42-mm{1,2}, 2.5.42-ac1 
>and it is not working in any case (oopsing just after RAMDISK: Compressed 
>image found...). I've sent decoded oops some time ago, without any 
>response. I cannot even try modular IDE because of that :/
>Please help

	Make sure you are not running CONFIG_HIGHMEM64G.  I believe there
is some kind of memory corruption problem under highmem=64g on x86 with
big ramdisks.  I use a ~900kB initial ramdisk that expands to ~2.2MB.

	With CONFIG_HIGHMEM4G or CONFIG_NOHIGHMEM, the problem disappears
for me.  I am writing this email under 2.5.41 with CONFIG_HIGHMEM4G and
IDE as a module (with a patch that I posted to lkml).

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
