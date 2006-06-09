Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWFIIEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWFIIEB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWFIIEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:04:01 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:24840 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751427AbWFIID5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:03:57 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: klibc
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<e65jj9$m9p$1@terminus.zytor.com>
	<200606071425.35802.ncunningham@linuxmail.org>
	<bda6d13a0606062351i5c94414fpa03ee2ce3dd180ae@mail.gmail.com>
	<e67fg0$grr$1@terminus.zytor.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: resistance is futile; you will be assimilated and byte-compiled.
Date: Fri, 09 Jun 2006 09:03:54 +0100
In-Reply-To: <e67fg0$grr$1@terminus.zytor.com> (H. Peter Anvin's message of "7 Jun 2006 22:14:44 +0100")
Message-ID: <8764ja7o2d.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jun 2006, H. Peter Anvin noted:
> Followup to:  <bda6d13a0606062351i5c94414fpa03ee2ce3dd180ae@mail.gmail.com>
> By author:    "Joshua Hudson" <joshudson@gmail.com>
> In newsgroup: linux.dev.kernel
>>
>> Did anybody ever fix the can't pivot_root() the rootfs filesystem;
>> hense can't use on a loopback system backed by NTFS?
> 
> You shouldn't pivot_root the rootfs filesystem.

What happens if you do? I mean, it doesn't make even conceptual sense,
really. The rootfs is always there: that's its entire purpose.

>                                                 Use the run-init
> utility or something similar instead (which does a mount with
> MS_MOVE.)

busybox has a switch_root tool which (conceptually) rm -rf's everything
on the root filesystem and then does such a mount. (After all whatever
is on that filesystem is inaccessible after the overmount, so keeping
it around is just a waste of memory.)

-- 
`Voting for any American political party is fundamentally
 incomprehensible.' --- Vadik
