Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVKZDuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVKZDuU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 22:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbVKZDuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 22:50:20 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:25226 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932186AbVKZDuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 22:50:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marc Koschewski <marc@osknowledge.org>
Subject: Re: Mouse issues in -mm
Date: Fri, 25 Nov 2005 22:50:13 -0500
User-Agent: KMail/1.8.3
Cc: Frank Sorenson <frank@tuxrocks.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Harald Welte <laforge@netfilter.org>
References: <20051123033550.00d6a6e8.akpm@osdl.org> <200511251727.24630.dtor_core@ameritech.net> <20051126025250.GA7000@stiffy.osknowledge.org>
In-Reply-To: <20051126025250.GA7000@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511252250.14372.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 November 2005 21:52, Marc Koschewski wrote:
> * Dmitry Torokhov <dtor_core@ameritech.net> [2005-11-25 17:27:24 -0500]:
> 
> > On Thursday 24 November 2005 04:40, Marc Koschewski wrote:
> > > I don't know why my touchpad is not listed. I have one and it perfectly
> > > works with X (same pointer as the mouse which is a Microsoft USB Wheel Mouse'
> > > attached to PS/2 using an appropriate adapter.
> > >
> > 
> > [I dropped netdev list from CC...] 
> > 
> > You have a Dell Inspiron, right? On Inspirons (and Latitudes) mouse
> > connected to external PS/2 port completely shadoes touchpad making
> > it invisible to the kernel.
> 
> I knew that. But just forgot. ;) However, that was not the prob I had. Was just
> wondering why it didn't show up in dmesg. I'll try to figure out, what made the
> mouse go crazy in -mm series. 
> 

The only change to psmouse module in -mm is that resync patch. If it still
gives you troubles after reverting it then something else is wrong in the
kernel. It looks there was some timer rework...

-- 
Dmitry
