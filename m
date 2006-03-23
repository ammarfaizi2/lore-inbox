Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWCWDO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWCWDO1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWCWDO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:14:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751399AbWCWDOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:14:23 -0500
Date: Wed, 22 Mar 2006 19:10:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Alessandro Suardi" <alessandro.suardi@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Zhu, Yi" <yi.zhu@intel.com>,
       James Ketrenos <jketreno@linux.intel.com>, netdev@vger.kernel.org
Subject: Re: [2.6.16-gitX] heavy performance regression in ipw2200 wireless
 driver
Message-Id: <20060322191057.304962a4.akpm@osdl.org>
In-Reply-To: <5a4c581d0603221724m391f5466l8a2af3ae7f0aacae@mail.gmail.com>
References: <5a4c581d0603221724m391f5466l8a2af3ae7f0aacae@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alessandro Suardi" <alessandro.suardi@gmail.com> wrote:
>

Pleeeeze try to cc the right people.

> Driver - or firmware ? Don't know - since the new git snapshots run
>  1.1.1 which requires newer firmware from http://ipw2200.sourceforge.net.
> 
> Symptom -> my new FC5 partition with 2.6.16-git kernels connects via
>  VNC viewer to my bittorrent box over wireless (ipw2200 to a D-Link
>  G604T router/AP); Dell D610 runs FC5, BT box is a K7-800 running
>  FC3 with a 2.6.16-rc5-git8 kernel (15+ days uptime...).
> 
> I also run Firefox on the bittorrent box; noticed today (2.6.16-git5) that
>  the screen refresh of pages with images was from time to time very
>  slow (close to unusable).
> 
> Rebooted into my FC4 partition with a 2.6.16 kernel, everything much
>  snappier. So I ran a scp test from my BT server to the laptop, three
>  times in a row the same file - a 38MB .flac with the laptop in the same
>  physical position (ie, no signal variation). Results...
> 
> FC5 - 2.6.16-git3:
> 
> [asuardi@donkey melua_2004-09-23_Berlin]$ scp KM_9-23-04_17_The\
> Closest\ Thing\ to\ Crazy.flac 192.168.1.8:/tmp
> asuardi@192.168.1.8's password:
> KM_9-23-04_17_The Closest Thing to Crazy.flac 100%   38MB 971.3KB/s   00:40
> [asuardi@donkey melua_2004-09-23_Berlin]$ scp KM_9-23-04_17_The\
> Closest\ Thing\ to\ Crazy.flac 192.168.1.8:/tmp
> asuardi@192.168.1.8's password:
> KM_9-23-04_17_The Closest Thing to Crazy.flac 100%   38MB   1.3MB/s   00:29
> [asuardi@donkey melua_2004-09-23_Berlin]$ scp KM_9-23-04_17_The\
> Closest\ Thing\ to\ Crazy.flac 192.168.1.8:/tmp
> asuardi@192.168.1.8's password:
> KM_9-23-04_17_The Closest Thing to Crazy.flac 100%   38MB 626.7KB/s   01:02
> 
> 
> FC4 - 2.6.16:
> 
> [asuardi@donkey melua_2004-09-23_Berlin]$ scp KM_9-23-04_17_The\
> Closest\ Thing\ to\ Crazy.flac 192.168.1.8:/tmp
> asuardi@192.168.1.8's password:
> KM_9-23-04_17_The Closest Thing to Crazy.flac 100%   38MB   1.5MB/s   00:25
> [asuardi@donkey melua_2004-09-23_Berlin]$ scp KM_9-23-04_17_The\
> Closest\ Thing\ to\ Crazy.flac 192.168.1.8:/tmp
> asuardi@192.168.1.8's password:
> KM_9-23-04_17_The Closest Thing to Crazy.flac 100%   38MB   1.7MB/s   00:23
> [asuardi@donkey melua_2004-09-23_Berlin]$ scp KM_9-23-04_17_The\
> Closest\ Thing\ to\ Crazy.flac 192.168.1.8:/tmp
> asuardi@192.168.1.8's password:
> KM_9-23-04_17_The Closest Thing to Crazy.flac 100%   38MB   1.7MB/s   00:22
> 
> Bottom line - old driver has better performance than the new one,
>  but most noticeably delivers consistent performance.
> 
> I will be available for testing starting Thursday 30th as I'll be on
>  the road since then. Of course if the problem is identified and
>  fixed earlier, I won't cry ;)

Well.  It's not a huge regression.  It's a 50%ish regression.  We've done
worse ;)

