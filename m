Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288594AbSA2Mlr>; Tue, 29 Jan 2002 07:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287841AbSA2Mld>; Tue, 29 Jan 2002 07:41:33 -0500
Received: from mx5.sac.fedex.com ([199.81.194.37]:59663 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S288810AbSA2MlE>; Tue, 29 Jan 2002 07:41:04 -0500
Date: Tue, 29 Jan 2002 20:36:52 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Thomas Hood <jdthood@mail.com>
cc: Jeff Chua <jchua@fedex.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: 2.4.18-pre7 slow ... apm problem
In-Reply-To: <1012249707.4807.123.camel@thanatos>
Message-ID: <Pine.LNX.4.44.0201292029410.892-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/29/2002
 08:40:59 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/29/2002
 08:41:01 PM,
	Serialize complete at 01/29/2002 08:41:01 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Thomas Hood wrote:

> Suggestion: Try setting the idle_threshold to a higher value,
> e.g., 98.  (The default value is 95.)

With 98, "ping localhost" on "guest" os showed 2 responses, then pause for
few seconds, then response, ...

With 95, I got the 1st response, then nothing. 98 seems better, but still
slow...

With 100, it's perfect.


> Try disabling APM cpu idling (set apm idle_threshold to 100) in the
> _guest_ OS.  (Leave it enabled in the host OS.)  Tell us what happens.

No difference, still slow. Even with guest os running pre6, it's still
slow.

>
> Also try disabling APM cpu idling (set apm idle_threshold to 100) in
> the _host_ OS.  (Leave it enabled in the guest OS.)  Tell us what
> happens.

guest os "ping localhost" is perfect.

> I repeat: You do not need to recompile the kernel to enable/disable
> APM cpu idle: to disable it simply set idle_threshold to 100.

Ok got it. But still have to reboot machine as the apm is loaded and can't
"rmmod apm". Complained that it's in use ([kapmd] even after stopping
apmd.

By the way, setting power_off=1 or realmode_power_off=1 does not power off
the h/w.


Thanks,
Jeff.

