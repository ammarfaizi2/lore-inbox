Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751864AbWB1QUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbWB1QUc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 11:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWB1QUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 11:20:32 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:50975 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751864AbWB1QUc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 11:20:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q5gHpGSaYCSODpo8Ko4cr0b/8kl1yxbjR0freffBRy/V4Fs9p6oRp5m3xxApul16maAvsB41trFS3FmQ5mBMqCkdKpfGbNvg5cz0LalV6drnPWZBViQS8qVnDeBqpTN7D93wPnSi4dSse0LXaZd84PTP6F30kaals/V5lT25xDg=
Message-ID: <6bffcb0e0602280820ic87332k@mail.gmail.com>
Date: Tue, 28 Feb 2006 17:20:31 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.16-rc5-mm1
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, rml@novell.com
In-Reply-To: <6bffcb0e0602280701h1d5cbeaar@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060228042439.43e6ef41.akpm@osdl.org>
	 <6bffcb0e0602280701h1d5cbeaar@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi,
>
> On 28/02/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm1/
> >
> >
> > - A large procfs rework from Eric Biederman.
> >
> > - The swap prefetching patch is back.
> >
> [snip]
> > +inotify-lock-avoidance-with-parent-watch-status-in-dentry.patch
> > +inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix.patch
>
> I have noticed this:
> Feb 28 15:13:42 ltg01-sid kernel: BUG: warning at
> /usr/src/linux-mm/fs/inotify.c:533/inotify_d_instantiate()
> Feb 28 15:13:42 ltg01-sid kernel:  [show_trace+13/15] show_trace+0xd/0xf
> Feb 28 15:13:42 ltg01-sid kernel:  [dump_stack+21/23] dump_stack+0x15/0x17
> Feb 28 15:13:42 ltg01-sid kernel:  [inotify_d_instantiate+47/98]
> inotify_d_instantiate+0x2f/0x62
> Feb 28 15:13:42 ltg01-sid kernel:  [d_instantiate+70/114]
> d_instantiate+0x46/0x72
> Feb 28 15:13:42 ltg01-sid kernel:  [ext3_add_nondir+44/64]
> ext3_add_nondir+0x2c/0x40
> Feb 28 15:13:42 ltg01-sid kernel:  [ext3_link+163/217] ext3_link+0xa3/0xd9
> Feb 28 15:13:42 ltg01-sid kernel:  [vfs_link+292/379] vfs_link+0x124/0x17b
> Feb 28 15:13:42 ltg01-sid kernel:  [sys_linkat+157/218] sys_linkat+0x9d/0xda
> Feb 28 15:13:42 ltg01-sid kernel:  [sys_link+20/25] sys_link+0x14/0x19
> Feb 28 15:13:42 ltg01-sid kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>
> Here is dmesg http://www.stardust.webpages.pl/files/mm/2.6.16-rc5-mm1/mm-dmesg
> Here is config http://www.stardust.webpages.pl/files/mm/2.6.16-rc5-mm1/mm-config

This patch is causing that warning
inotify-lock-avoidance-with-parent-watch-status-in-dentry.patch

It's full reproductible on my system, it appears when I start mozilla
thunderbird (v 1.0.7).

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
