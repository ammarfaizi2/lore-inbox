Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVCaQDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVCaQDF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVCaQDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:03:04 -0500
Received: from digitalimplant.org ([64.62.235.95]:33730 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261518AbVCaQCv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:02:51 -0500
Date: Thu, 31 Mar 2005 08:02:44 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Andy Isaacson <adi@hexapodia.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp at
 fault?
In-Reply-To: <200503310226.03495.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.50.0503310801410.15519-100000@monsoon.he.net>
References: <20050329181831.GB8125@elf.ucw.cz>
 <1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
 <20050329223519.GI8125@elf.ucw.cz> <200503310226.03495.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Mar 2005, Dmitry Torokhov wrote:

> Ok, what do you think about this one?
>
> ===================================================================
>
> swsusp: disable usermodehelper after generating memory snapshot and
>         before resuming devices, so when device fails to resume we
>         won't try to call hotplug - userspace stopped anyway.

Hm, shouldn't we disable it before we start to freeze processes? We don't
want any more processes trying to start up after we've taken care of
them..

Thanks,


	Pat

