Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbUK0Tp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbUK0Tp6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 14:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUK0Tp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 14:45:58 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:10392 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261316AbUK0Tpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 14:45:54 -0500
Date: Sat, 27 Nov 2004 20:45:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Richard Patterson <vectro@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Seekable pipes
In-Reply-To: <20041127054852.47669.qmail@web13523.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0411272044390.27610@yvahk01.tjqt.qr>
References: <20041127054852.47669.qmail@web13523.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,
>
>I want to implement an interface for seekable pipes
>(and FIFOs) in the Linux kernel.  The basic idea of
>this is that when the reader issues a seek(), this
>information can be passed onto the writer, who will
>continue writing from the new location. Since the
>reader doesn't have to do anything special, this
>allows user-space programs to simulate real files,
>providing features such as network filesystems and
>database large-objects, all in user space.

Why not simply create two pipes, and use one for the data (from writer to
reader) and the other for control (r->w)? Then you would not need to poke with
the kernel after all.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
