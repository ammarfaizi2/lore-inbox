Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752442AbWAFQ0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbWAFQ0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbWAFQ0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:26:41 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:54538 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752442AbWAFQ0k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:26:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c/GL+R5JKOfyHSIcQQ1tWBqe2nWQuU2OXZvuDej7CpGhOaqdmEK9opEHGGyjZdloBlD6XjcomxPigeF/ESRZcWX6tetUgiVopY+WKPxiCus4nTmfXRP6SbYaNb0I6L3atzTlsIOy0LXa+TYrp+aQ6wEdsVfjTD62v4VMhrMbzQs=
Message-ID: <d120d5000601060826p28ff7e69l96f0e0b9287c6c0f@mail.gmail.com>
Date: Fri, 6 Jan 2006 11:26:39 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: mouse issues in 2.6.15-rc5-mm series
Cc: Marc Koschewski <marc@osknowledge.org>, Joe Feise <jfeise@feise.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43BE2A3A.9000706@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43ACEE14.7060507@feise.com>
	 <200512252309.07162.dtor_core@ameritech.net>
	 <43AF742E.5040604@tuxrocks.com>
	 <200601042224.08509.dtor_core@ameritech.net>
	 <43BE2A3A.9000706@tuxrocks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Frank Sorenson <frank@tuxrocks.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Dmitry Torokhov wrote:
> > On Sunday 25 December 2005 23:40, Frank Sorenson wrote:
> >
> >>Dmitry Torokhov wrote:
>
> >>>Does the tapping not work period or it only does not work first time you
> >>>try to tap after not touching the pad for more than 5 seconds?
> >>
> >>The tapping works initially, then stops.  I hadn't put 2+2 together with
> >>the 5-second idle bit, but that seems the likely issue.
> >>
> >>I applied that patch you sent out yesterday, and now tapping works and
> >>I'm not seeing the mouse stall/jump problem.  I'm at 21+ hours uptime
> >>now, with no mouse problems, so I think setting the resync_time to 0
> >>looks like the right fix.
>
> > Frank,
> >
> > Could you please try the patch below and see if it makes tapping work?
> > Make sure you enable resynching by doing:
> >
> >       echo -n 5 > /sys/bus/serio/devices/serioX/resync_time
>
> With this patch (on top of 2.6.15-mm1, right?), I see the mouse
> stall/jump problem, but tapping appears to continue working.  The
> touchpad also seems to be extremely touchy.  I get spurious taps with
> very little pressure, and sometimes double-tap will select, then
> immediately deselect.
>

I just want to confirm that when testing the patch you forced the
touchpad into PS/2 mode with psmouse.proto=exps, right?

Could you please enable i8042 debug (echo 1 >
/sys/modules/i8042/parameters/debug), move pointer and do coulple of
taps and touble-taps making sure there is 5 seconds intervals between
events and send me dmesg. Or is the mouse jerky and touchy even while
you using it continuously, without 5 seconds pauses?

--
Dmitry
