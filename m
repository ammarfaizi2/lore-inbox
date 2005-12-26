Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbVLZEzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVLZEzs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 23:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVLZEzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 23:55:48 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:58214 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751011AbVLZEzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 23:55:47 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: mouse issues in 2.6.15-rc5-mm series
Date: Sun, 25 Dec 2005 23:55:44 -0500
User-Agent: KMail/1.9.1
Cc: Marc Koschewski <marc@osknowledge.org>, Joe Feise <jfeise@feise.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <43ACEE14.7060507@feise.com> <200512252309.07162.dtor_core@ameritech.net> <43AF742E.5040604@tuxrocks.com>
In-Reply-To: <43AF742E.5040604@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512252355.45254.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 December 2005 23:40, Frank Sorenson wrote:
> Dmitry Torokhov wrote:
> > On Saturday 24 December 2005 05:57, Frank Sorenson wrote:
> >
> >>I continue to see the same issues with the resync patch in -mm.  For me,
> >>tapping stops working, and I'm now seeing both the mouse pointer jumping
> >> as well (a lesser issue for me, so it was probably present earlier as
> >>well).
> >>
> >
> > Frank,
> >
> > Does the tapping not work period or it only does not work first time you
> > try to tap after not touching the pad for more than 5 seconds?
> 
> The tapping works initially, then stops.  I hadn't put 2+2 together with
> the 5-second idle bit, but that seems the likely issue.
> 
> I applied that patch you sent out yesterday, and now tapping works and
> I'm not seeing the mouse stall/jump problem.  I'm at 21+ hours uptime
> now, with no mouse problems, so I think setting the resync_time to 0
> looks like the right fix.
>

Well, no, that's a band-aid ;) There are still touchpads speaking 4-byte
protocols so I still need to adjust resync code to work with tapping.

-- 
Dmitry
