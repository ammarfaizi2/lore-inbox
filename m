Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318018AbSHCX1G>; Sat, 3 Aug 2002 19:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318026AbSHCX1G>; Sat, 3 Aug 2002 19:27:06 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:10561 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S318018AbSHCX1F>;
	Sat, 3 Aug 2002 19:27:05 -0400
Date: Sun, 4 Aug 2002 01:30:35 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Skip Ford <skip.ford@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.30 LILO FreeBSD partition problems
Message-ID: <20020803233035.GA29008@win.tue.nl>
References: <200208032300.g73N0Pix000183@pool-141-150-241-241.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208032300.g73N0Pix000183@pool-141-150-241-241.delv.east.verizon.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2002 at 07:00:21PM -0400, Skip Ford wrote:

> While running 2.5.30 I receive this error when running LILO with a
> FreeBSD partition in lilo.conf
> 
>   Device 0x0300: Invalid partition table, 3rd entry
>     3D address:     1/0/530 (534240)
>     Linear address: 1/14/8446 (8514450)
> 
> I removed the fbsd entry and LILO had no problems.  I then booted
> to 2.4 and readded the fbsd partition and it installed fine.

Which LILO version is this?
What do cfdisk -Ps /dev/hda and cfdisk -Pt /dev/hda say?
What are the kernel boot messages for this disk
(dmesg | grep hda), both for 2.5.29 and 2.5.30?

Andries

[lilo-22.3.1 does not print such messages.
Must be from the part_verify() in some older LILO.
Probably some LILO option like "ignore-table" or "linear" or "lba32"
would help. But it is interesting to see where this 1/0/530 comes from.]
