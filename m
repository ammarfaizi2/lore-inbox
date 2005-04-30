Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVD3M17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVD3M17 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 08:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVD3M16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 08:27:58 -0400
Received: from mail.aei.ca ([206.123.6.14]:37082 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261206AbVD3M1z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 08:27:55 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm1
Date: Sat, 30 Apr 2005 08:27:43 -0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050429231653.32d2f091.akpm@osdl.org>
In-Reply-To: <20050429231653.32d2f091.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504300827.44359.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 April 2005 02:16, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm1/
> 
> - There's still a bug in the new timer code.  If you think you hit it,
>   please revert 
> 
>         timers-fixes-improvements-fix.patch                     then
>         timers-fixes-improvements-smp_processor_id-fix.patch    then
>         timers-fixes-improvements.patch
> 
>   or, better, fix the bug.
> 
> - If you use mpt-fusion, beware that the CONFIG_* names got changed - if you
>   blindly do `make oldconfig' you won't have any disks.
> 
> - ia64 crashes when doing a PM poweroff.  It's triggered by
>   properly-stop-devices-before-poweroff.patch but appears to be an ia64 bug.
> 
> - Lots of bk trees were dropped and lots of git trees and patch serieses
>   were picked up.  I think all the subsystem trees are here, but the bk ones
>   are starting to rot.  As far as I can tell, no subsystem maintainers are
>   updating their bk trees (apart from acpi).ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm1/

Andrew, 

If we stick with git it might make sense not to include a linux-patch.  cogito
is quite fast to export using a commit id.  Suspect some bandwidth could be 
saved if you just stated the commit id that you based the mm patch on.

In case anyone is wondering how build this from a cogito/git db...  Find the
cogito announcement on lkml install and update cogito.  Then folliw the instructions
in the README and download the kernel's db.  Next search lkml to find the commit id 
of rc3 (a2755a80f40e5794ddc20e00f781af9d6320fafb) and verify you have it correct 
with:

cg-mkpatch a2755a80f40e5794ddc20e00f781af9d6320fafb

then export a tree with

cg-export ../12-3-1 a2755a80f40e5794ddc20e00f781af9d6320fafb

and cd over to the new dir and patch with mm and have fun.

Thanks

Ed Tomlinson




