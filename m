Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWG3Low@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWG3Low (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWG3Low
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:44:52 -0400
Received: from styx.suse.cz ([82.119.242.94]:39652 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932272AbWG3Lov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:44:51 -0400
Date: Sun, 30 Jul 2006 13:44:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Valdis.Kletnieks@vt.edu
Cc: Shem Multinymous <multinymous@gmail.com>, Pavel Machek <pavel@suse.cz>,
       "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060730114446.GA4898@suse.cz>
References: <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz> <20060728134307.GD29217@suse.cz> <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com> <200607281557.k6SFvn09022794@turing-police.cc.vt.edu> <41840b750607281510j2c5babf8x9fac51fe6910aeda@mail.gmail.com> <200607282314.k6SNESSg019274@turing-police.cc.vt.edu> <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com> <200607300835.k6U8ZvSB016669@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607300835.k6U8ZvSB016669@turing-police.cc.vt.edu>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 04:35:57AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sat, 29 Jul 2006 12:48:51 +0300, Shem Multinymous said:
> 
> > The lazy polling approach I described in my last post to Vojtech
> > ("block until there's  a new readout or N milliseconds have passed,
> > whichever is later") looks like a more general, accurate and efficient
> > interface.
> 
> That's not good.
> 
> If the program says '100ms' because it knows it will need to do a GUI update
> then, and you block it for 5 seconds because that's when the next value
> update happens, the user is stuck looking at their gkrellm or whatever not
> doing anything at all for 4.9 seconds....
> 
> This almost forces the use of multiple threads if the program wants to do
> its own timer management.

The application can use select() to wait both for any X events it needs
to service and for the data update at the same time, right?

-- 
Vojtech Pavlik
Director SuSE Labs
