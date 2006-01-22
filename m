Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWAVF2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWAVF2q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 00:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWAVF2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 00:28:45 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:41303 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750768AbWAVF2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 00:28:45 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: 2.6.15.1: Frequent keyboard driver reset
Date: Sun, 22 Jan 2006 00:28:40 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
References: <200601220012.05970.arvidjaar@mail.ru>
In-Reply-To: <200601220012.05970.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601220028.41161.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 January 2006 16:11, Andrey Borzenkov wrote:
> I have Ali based Toshiba notebook. In dmesg I see frequent resets like:
> 
> input: AT Translated Set 2 keyboard as /class/input/input6
> input: AT Translated Set 2 keyboard as /class/input/input7
> input: AT Translated Set 2 keyboard as /class/input/input8
> 
> Interesting is I checked sysfs after having seen those messages and
> 
> {pts/0}% LC_ALL=C ll /sys/class/input
> total 0
> drwxr-xr-x  6 root root 0 Jan 21 13:14 input1/
> drwxr-xr-x  4 root root 0 Jan 21 23:54 input8/
> drwxr-xr-x  2 root root 0 Jan 21 13:14 mice/
> lrwxrwxrwx  1 root root 0 Jan 22 00:02 mouse0
> -> ../../class/input/input1/mouse0/
> lrwxrwxrwx  1 root root 0 Jan 22 00:02 ts0 -> ../../class/input/input1/ts0/
> 
> So it appears similar to SCSI - old instance is stuck and new instance is
> created.
>

Hmm, I lost you... input1 is mouse, input8 is keyboard. I don't see
anything "stuck" here.

> How can I debug it further? System information:
>

I would start with opening the notebook and reseating keyboard cable.
 
-- 
Dmitry
