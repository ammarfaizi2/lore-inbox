Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUGDRKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUGDRKd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 13:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUGDRKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 13:10:33 -0400
Received: from cantor.suse.de ([195.135.220.2]:43966 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265212AbUGDRKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 13:10:31 -0400
Date: Sun, 4 Jul 2004 19:10:28 +0200
From: Olaf Hering <olh@suse.de>
To: Jurriaan <thunder7@xs4all.nl>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.7-bk16, mode-switch-in-fbcon_blank.patch breaks X on r128
Message-ID: <20040704171028.GA22469@suse.de>
References: <20040704160358.GA20970@suse.de> <20040704164037.GA18255@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20040704164037.GA18255@middle.of.nowhere>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Jul 04, Jurriaan wrote:

> From: Olaf Hering <olh@suse.de>
> Date: Sun, Jul 04, 2004 at 06:03:58PM +0200
> > 
> > This patch, which went into 2.6.7-bk16, breaks X on my ibook with r128
> > chipset. X starts just fine, but the screen stays black. I can switch to
> > a textconsole and the console login appears.
> > 
> > I see no errors in dmesg or XFree86.0.log. Its version 4.3.0 from SuSE 8.2.
> > 
> 
> I also had problems (switching back from X to console rewrote my refresh
> rate from 85 to 60 Hz) and this patch was posted in the
> linux-fbdev-devel mailinglist which solved my problems.
> 
> could you try it and let Antonino A Daplas (adaplas @ pol.net) know if
> this worked for you?

No, this will not work, fbcon_resize() is called before fbcon_blank(). I
think the removed code in fbcon_blank() is needed.
