Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319249AbSHNREQ>; Wed, 14 Aug 2002 13:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319250AbSHNREQ>; Wed, 14 Aug 2002 13:04:16 -0400
Received: from ppp77-4-71.miem.edu.ru ([194.226.32.71]:19328 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S319249AbSHNREP>;
	Wed, 14 Aug 2002 13:04:15 -0400
Message-ID: <3D5A8948.7060201@yahoo.com>
Date: Wed, 14 Aug 2002 20:46:00 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Michael Knigge <Michael.Knigge@set-software.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New PC-Speaker driver
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Michael Knigge wrote:
 > Oh, I would love to see that thing in the Standard-Kernel....
Yes, I'd also like to see it there, but
for now I don't know if/when this can be
achieved.
As pointed by David Woodhouse (from whom
I've stolen the code just because I felt
it was not updated for tooo long:) the main
problem is that this driver, dispite no longer
touching irq.c (the latest patch doesn't touch
it) still speeds up the timer (this is
unavoidable). Well, as in 2.5 HZ is configurable,
this is probably a way to go (but I haven't
yet played with 2.5).
However, since 2.5 uses ALSA rather than OSS, I
think I have to make an ALSA port before thinking
about an integration. But even if this is done,
somehow this must be dealt with:
http://www.alsa-project.org/archive/alsa-user/msg04284.html

So there are anough of long-term issues and for
2.4 solving them is not possible.
My goal for 2.4 is to get rid of the native fops
and use OSS fops instead (USE_OSS_FOPS in pcsp.h
must be set to 1) but even this doesn't work very
well: when CPU load is high, my output routines
are called with the sound buffer entirely zeroed
out! I don't know who wipes out the buffer on a
high CPU load and as the problem is deeply buried
in the OSS internals (not in my driver) I don't
know how to deal with that.

 > Thanks for your work! This is something I was missing for
 > years!
Thanks:) I'll try to make this driver acceptable
for inclusion, but this will take *a lot* of time.

