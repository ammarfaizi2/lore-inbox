Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752085AbWCBX3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbWCBX3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbWCBX3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:29:03 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:34869 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752085AbWCBX3B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:29:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=koGBAWkPpsyIPP+JK+4MLTaPwp9fCltEl55w36GqQ1C/0EVOJZHVanJP+HLcWK5JZg870MH7BZpmr6SZls2HDPEqtiugyg7jqzVs3hSlKWfE2wtJ/hPPnb6f1rL4OHp+gPGUR16+6Yj8E2Xyr0YhARqBjW9uZG0M+CLrS8ZPg0o=
Message-ID: <6bffcb0e0603021529x86f32c6h@mail.gmail.com>
Date: Fri, 3 Mar 2006 00:29:00 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Bernhard Rosenkraenzer" <bero@arklinux.org>
Subject: Re: 2.6.16-rc5-mm1: inotify BUG warnings
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200603022104.14073.bero@arklinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603022104.14073.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/03/06, Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
> I'm getting a number of those when running KDE 3.5.1 on a 2.6.16-rc5-mm1 box:
>
> Mar  2 20:51:44 ch kernel: BUG: warning at
> fs/inotify.c:533/inotify_d_instantiate()
> Mar  2 20:51:44 ch kernel:  [<b0187017>] inotify_d_instantiate+0x57/0x60
> Mar  2 20:51:44 ch kernel:  [<b0176da2>] d_instantiate+0x42/0x90
> Mar  2 20:51:44 ch kernel:  [<b01a761c>] ext3_add_nondir+0x3c/0x60
> Mar  2 20:51:44 ch kernel:  [<b01a8016>] ext3_link+0xa6/0xf0
> Mar  2 20:51:44 ch kernel:  [<b016c67e>] vfs_link+0x14e/0x1b0
> Mar  2 20:51:44 ch kernel:  [<b016fa8e>] sys_linkat+0x11e/0x140
> Mar  2 20:51:44 ch kernel:  [<b014b2ec>] __handle_mm_fault+0x66c/0x820
> Mar  2 20:51:44 ch kernel:  [<b0114650>] do_page_fault+0x420/0x6ce
> Mar  2 20:51:44 ch kernel:  [<b016fadf>] sys_link+0x2f/0x40
> Mar  2 20:51:44 ch kernel:  [<b0102e13>] sysenter_past_esp+0x54/0x75
>
> Other than these, the system seems to run perfectly.

It is known issue, harmless.

You can revert these patches:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm1/broken-out/inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix.patch
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm1/broken-out/inotify-lock-avoidance-with-parent-watch-status-in-dentry.patch

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
