Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263999AbTI2Rte (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbTI2Rs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:48:58 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:22191 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263969AbTI2RrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:47:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>, Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: [BUG] Defunct event/0 processes under 2.6.0-test6-mm1
Date: Mon, 29 Sep 2003 12:47:17 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20030929155042.53666.qmail@web40910.mail.yahoo.com> <20030929094136.0b4bb026.akpm@osdl.org>
In-Reply-To: <20030929094136.0b4bb026.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309291247.18164.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 September 2003 11:41 am, Andrew Morton wrote:
> Bradley Chapman <kakadu_croc@yahoo.com> wrote:
> > I am experiencing defunct event/0 kernel daemons under
> > 2.6.0-test6-mm1 with synaptics_drv 0.11.7, Dmitry Torokhov's gpm-1.20
> > with synaptics support, and XFree86 4.3.0-10. Moving the touchpad in
> > either X or with gpm causes defunct event/0 processes to be created.
>
> Defunct is odd.  Have you run `dmesg' to see if the kernel oopsed?
>
> You could try reverting synaptics-reconnect.patch, and then
> serio-reconnect.patch from
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-tes
>t6/2.6.0-test6-mm1/broken-out
>

Input subsystem uses only one kernel thread called kseriod, not eventsX.
I think it's not synaptics/serio reconnect but other patch you mentioned
(call_usermodehelper-retval-fix-2.patch)

Dmitry
