Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262968AbVHEKnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbVHEKnk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbVHEKlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:41:37 -0400
Received: from mail.gmx.de ([213.165.64.20]:42912 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262960AbVHEKlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:41:21 -0400
X-Authenticated: #1725425
Date: Fri, 5 Aug 2005 12:40:21 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, frank.peters@comcast.net,
       vojtech@suse.cz
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Message-Id: <20050805124021.3a2ba4f0.Ballarin.Marc@gmx.de>
In-Reply-To: <200508042307.33880.dtor_core@ameritech.net>
References: <20050624113404.198d254c.frank.peters@comcast.net>
	<200508042220.27480.dtor_core@ameritech.net>
	<20050804205441.0a90f637.akpm@osdl.org>
	<200508042307.33880.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005 23:07:33 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> It requests BIOS to hand off control of USB which disables USB legacy emulation
> and all troubles associated with it. We could start with -mm...

This also fixes an issue I encountered while doing power measurements:
without uhci-hcd loaded, the system could not enter C3 state.
This could be fixed by either loading uhci-hcd without devices attached or
by specifying "usb-handoff".

So, this can also fix "silent" issues.

Regards
