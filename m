Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKSJwZ>; Sun, 19 Nov 2000 04:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129255AbQKSJwP>; Sun, 19 Nov 2000 04:52:15 -0500
Received: from olsinka.site.cas.cz ([147.231.11.16]:7808 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S129152AbQKSJv5>;
	Sun, 19 Nov 2000 04:51:57 -0500
Date: Sun, 19 Nov 2000 10:21:43 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: rdtsc to mili secs?
Message-ID: <20001119102143.A529@suse.cz>
In-Reply-To: <3A078C65.B3C146EC@mira.net> <20001116115730.A665@suse.cz> <8v1pfj$p5e$1@cesium.transmeta.com> <20001118211349.B382@bug.ucw.cz> <8v74fm$2d7$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8v74fm$2d7$1@cesium.transmeta.com>; from hpa@zytor.com on Sat, Nov 18, 2000 at 03:48:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 03:48:06PM -0800, H. Peter Anvin wrote:
> Followup to:  <20001118211349.B382@bug.ucw.cz>
> By author:    Pavel Machek <pavel@suse.cz>
> In newsgroup: linux.dev.kernel
> 
> > > Actually, on machines where RDTSC works correctly, you'd like to use
> > > that to detect a lost timer interrupt.
> > > 
> > > It's tough, it really is :(
> > 
> > Well, my patch did not do that but you probably want lost timer
> > interrupt detection so that you avoid false alarms.
> > 
> > But that means you can no longer detect speed change after 10msec:
> > 
> > going from 150MHz to 300MHz is very similar to one lost timer
> > interrupt.
> > 
> 
> That's the point.

... and, you still can have both - detection of lost timer interrupts
and detection of speed changing. It'll take longer than 10ms to notice,
though (I think 20 or 30 will just do it).

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
