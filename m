Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVC2TJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVC2TJJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVC2TJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:09:08 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:15494 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261308AbVC2TJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:09:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GxRrwx4lgYOmogRZW0aE/YL/q6mkH6UTvgnIA+Ze+u7s1qfQEw089coChPQW+qXNbtIp8iyTuiCcNXc/Ex7rZUV0L45MS5lGPhkG+OBiZyH58xdPwU/Mp6CPaXXwDi0jwgUnDmrMr8/xIPO7gafjFGVv1khVlu3J1qqof3zQwPQ=
Message-ID: <d120d50005032911027c13436e@mail.gmail.com>
Date: Tue, 29 Mar 2005 14:02:00 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alexey Dobriyan <adobriyan@mail.ru>
Subject: Re: 2.6.12-rc1-bk2+PREEMPT_BKL: Oops at serio_interrupt
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200503292128.20140.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <200503282126.55366.adobriyan@mail.ru>
	 <200503290127.52614.dtor_core@ameritech.net>
	 <200503292128.20140.adobriyan@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005 21:28:20 +0400, Alexey Dobriyan <adobriyan@mail.ru> wrote:
> On Tuesday 29 March 2005 10:27, Dmitry Torokhov wrote:
> > On Monday 28 March 2005 12:26, Alexey Dobriyan wrote:
> > > Steps to reproduce for me:
> > >     * Boot CONFIG_PREEMPT_BKL=y kernel (.config, dmesg are attached)
> > >     * Start rebooting
> > >     * Start moving serial mouse (I have Genius NetMouse Pro)
> > >     * Right after gpm is shut down I see the oops
> > >     * The system continues to reboot
> >
> > Could you try the patch below, please? Thanks!
> 
> > Input: serport - fix an Oops when closing port - should not call
> >        serio_interrupt when serio port is being unregistered.
> 
> Doesn't work, sorry. Even worse: rebooting now also produces many pages of
> oopsen, then hang the system. I'm willing to test any new patches.
> 

Does it oops at the same place with this patch or at some other place?
Btw, what happen if you try to kill inputattach or GPM or both without
rebooting?

-- 
Dmitry
