Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVDDGwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVDDGwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 02:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVDDGwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 02:52:41 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:17620 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261568AbVDDGwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 02:52:23 -0400
Subject: Re: [PATCH 4/4] psmouse: dynamic protocol switching via sysfs
From: Kenan Esau <kenan.esau@conan.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: harald.hoyer@redhat.de, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200504040045.19263.dtor_core@ameritech.net>
References: <20050217194217.GA2458@ucw.cz>
	 <200503220217.47624.dtor_core@ameritech.net>
	 <1112557765.3625.9.camel@localhost>
	 <200504040045.19263.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 08:48:34 +0200
Message-Id: <1112597314.3625.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 04.04.2005, 00:45 -0500 schrieb Dmitry Torokhov:
> Hi Kenan,
> 

[..]

> > If I do "echo -n 50 > resolution" "0xe8 0x01" is sent. I don't know if
> > this is correct for "usual" PS/2-devices but for the lifebook it's
> > wrong.
> > 
> > For the lifebook the parameters are as following:
> > 
> > 50cpi  <=> 0x00
> > 100cpi <=> 0x01
> > 200cpi <=> 0x02
> > 400cpi <=> 0x03
> > 
> 
> "Classic" PS/2 protocol specifies available resolutions of 1, 2, 4 and 8
> units per mm which gives you 25, 50, 100 and 200 cpi respectively. I am
> surprised that Lifebook simply doubles the rates, but if it does I guess
> the patch below will suffice. 

Yes -- exactly. That was what I was thinking about. I was just not shure
whether it is lifebook specific or not.

I haven't tested the patch yet. But by inspecting the code it looks
good ;-)




