Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbUATOhL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 09:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265535AbUATOhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 09:37:11 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:50643 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S265533AbUATOhK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 09:37:10 -0500
Date: Tue, 20 Jan 2004 16:37:01 +0200 (EET)
From: =?iso-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>
X-X-Sender: midian@midi
To: Takashi Iwai <tiwai@suse.de>
cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: ALSA vs. OSS
In-Reply-To: <s5hy8s27kz0.wl@alsa2.suse.de>
Message-ID: <Pine.LNX.4.44.0401201635140.20268-100000@midi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004, Takashi Iwai wrote:

> At Tue, 20 Jan 2004 16:17:13 +0200,
> Markus Hästbacka wrote:
> ...
>
> then it's a different problem.
>
Aha.
> sb live has a single capture (record) device although it can play
> multiple streams at the same time.  when both apps try to open
> fullduplex, the later one is blocked, because the capture device is
> already occupied.
> if it's the case, it is not a bug but the correct POSIX behavior.
>
> as a workaround, try to add the following to /etc/modprobe.conf:
>
> 	alias snd-pcm-oss nonblock_open=1
>
> this will set the OSS PCM devices as non-blocking.
>
I'll try that
Thanks,
	Markus

