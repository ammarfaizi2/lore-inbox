Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUA2G4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 01:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUA2G4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 01:56:17 -0500
Received: from smtp1.pp.htv.fi ([212.90.64.119]:50831 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S266143AbUA2G4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 01:56:11 -0500
Subject: Re: [Bug 1959] New: cs46xx driver mmap_valid 0-->1 in kernel 2.6?
From: Janne Pikkarainen <jaba@mikrobitti.fi>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1075359415.10166.23.camel@cs90174.pp.htv.fi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Jan 2004 08:56:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone, I just subscribed to this list...

At Tue, 27 Jan 2004 07:14:40 -0800,
Martin J. Bligh wrote:
>> 
>> Is there a reason to keep mmap_valid=0 in cs46xx driver or is this a real bug? I
>> haven't seen any new bugs with this patch applied, all the multimedia
>> applications (mplayer, xine, xmms, noatun) keeps on working.

> cs46xx doesn't always support the direct hardware buffer.
> Only in some cases with a proper period (fragment) numbers, it can
> support the direct buffer access.  mmap_valid option forces the driver
> to allow OSS apps the direct accessing via mmap.  This might not work
> always, depending on the parameter the app uses.  Use at your own
> risk.
>
> In short: it's not a real bug as long as mmap_valid=1 option works.
> You had luck that your OSS apps (using mmap) seem working :)

If this is the case and if there are other applications affected by this
than Enemy Territory and Wine mentioned in bug #1959, maybe the 
"use mmap_valid 0/1" option should made selectable by the user in 
kernel menuconfig? Of course with the proper "Caution: selecting 
mmap_valid may cure some applications while hurting the others" warnings
attached.

I mean, for example I thought for a long time that cs46xx is much more 
badly broken in kernel 2.[56].x than it in reality seems to be. No new 
sound bugs ever since I've applied this mmap_valid 0-->1 patch and I 
think the first time I patched the driver was around 2.6.0-test1.

The sound card I have is Hercules SoundFusion Fortissimo III 7.1 
(or something like that).

