Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVC2R2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVC2R2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 12:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVC2R2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 12:28:10 -0500
Received: from mx1.mail.ru ([194.67.23.121]:31071 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261264AbVC2R2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 12:28:08 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.12-rc1-bk2+PREEMPT_BKL: Oops at serio_interrupt
Date: Tue, 29 Mar 2005 21:28:20 +0400
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <200503282126.55366.adobriyan@mail.ru> <200503290127.52614.dtor_core@ameritech.net>
In-Reply-To: <200503290127.52614.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503292128.20140.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 March 2005 10:27, Dmitry Torokhov wrote:
> On Monday 28 March 2005 12:26, Alexey Dobriyan wrote:
> > Steps to reproduce for me:
> > 	* Boot CONFIG_PREEMPT_BKL=y kernel (.config, dmesg are attached)
> > 	* Start rebooting
> > 	* Start moving serial mouse (I have Genius NetMouse Pro)
> > 	* Right after gpm is shut down I see the oops
> > 	* The system continues to reboot
> 
> Could you try the patch below, please? Thanks!

> Input: serport - fix an Oops when closing port - should not call
>        serio_interrupt when serio port is being unregistered.

Doesn't work, sorry. Even worse: rebooting now also produces many pages of
oopsen, then hang the system. I'm willing to test any new patches.
