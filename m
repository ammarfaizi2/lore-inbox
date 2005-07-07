Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVGGPDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVGGPDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVGGO6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 10:58:54 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:53275 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261437AbVGGO5C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 10:57:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A+vMJ+D9hWzSpdtqBxM+oxLP0wBzaaaDVjGnPxmVBWaX3j62lfjAbbVaZS39gzIyS5wKvs4xBGMMaxFyw87u2mnrik4R8wJJaCqkimj5n/0jmLhrN9hkbtXlTCgvEczro/bhDMczl3nG/hRNCRKbzoD2NGCA49KlFPpNiHrAKZc=
Message-ID: <a44ae5cd0507070756241dbea1@mail.gmail.com>
Date: Thu, 7 Jul 2005 07:56:58 -0700
From: Miles Lane <miles.lane@gmail.com>
Reply-To: Miles Lane <miles.lane@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: OOPS in 2.6.13-rc1-mm1 -- EIP is at sysfs_release+0x49/0xb0
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e9970507070331107831c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a44ae5cd05070301417531fac2@mail.gmail.com>
	 <21d7e9970507070331107831c6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, in my Xorg log I find this:

(II) I810(0): [drm] created "i915" driver at busid "pci:0000:00:02.0"
(WW) I810(0): i830 Kernel module detected, Use the i915 Kernel module
instead, aborting DRI init.

(II) I810(0): [drm] DRM interface version 1.2
(II) I810(0): [drm] created "i915" driver at busid "pci:0000:00:02.0"
(II) I810(0): [drm] added 8192 byte SAREA at 0xf916e000
(II) I810(0): [drm] mapped SAREA 0xf916e000 to 0xb7d38000
(II) I810(0): [drm] framebuffer handle = 0xe8020000
(II) I810(0): [drm] added 1 reserved context for kernel
(II) I810(0): [drm] removed 1 reserved context for kernel
(II) I810(0): [drm] unmapping 8192 bytes of SAREA 0xf916e000 at 0xb7d38000




On 7/7/05, Dave Airlie <airlied@gmail.com> wrote:
> On 7/3/05, Miles Lane <miles.lane@gmail.com> wrote:
> > mtrr: base(0xe8020000) is not aligned on a size(0x3c0000) boundary
> > [drm:drm_unlock] *ERROR* Process 4470 using kernel context 0
> > mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x1000000
> > Unable to handle kernel paging request at virtual address 5f78735f
> 
> That is a bit suspicious.. what distro/X are you using? if you are
> running a newer X (I think anything after XFree86 4.3) you should be
> using the i915 DRM not the i830..
> 
> Dave.
>
