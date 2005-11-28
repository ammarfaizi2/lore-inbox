Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbVK1GB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVK1GB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 01:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVK1GB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 01:01:28 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:20350 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751245AbVK1GB2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 01:01:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: psmouse unusable in -mm series (was: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine)
Date: Mon, 28 Nov 2005 01:01:21 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Marc Koschewski <marc@osknowledge.org>,
       Ed Tomlinson <tomlins@cam.org>
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <200511252350.28129.dtor_core@ameritech.net> <200511261828.58875.rjw@sisk.pl>
In-Reply-To: <200511261828.58875.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511280101.21738.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 November 2005 12:28, Rafael J. Wysocki wrote:
> On Saturday, 26 of November 2005 05:50, Dmitry Torokhov wrote:
> > On Friday 25 November 2005 22:54, Dmitry Torokhov wrote:
> > > > Actually, it works on the console (ie with gpm), but X is unable to use it,
> > > > apparently.  However it used to be, at least on 2.6.14-git9 (this is the latest
> > > > non-mm kernel I've been able to test quickly on this box).
> > > >
> > > 
> > > Rafael,
> > > 
> > > does reverting the following patch makes touchpad work?
> > 
> > Or, try dropping this patch on top of -mm.
> 
> That helps (additionally I've dropped "const" from the header of
> evdev_event_to_user, to avoid warnings).
>

Thank you for testing it.

For some reason sparc64 cross-compiler that I have did not issue any
warnings for the old code. I now tried doing x86_64 cross-compile and
it indeed warns me about constness and other problems.

-- 
Dmitry
