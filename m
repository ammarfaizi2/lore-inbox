Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWAEVsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWAEVsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbWAEVsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:48:16 -0500
Received: from digitalimplant.org ([64.62.235.95]:17631 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1750975AbWAEVsP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:48:15 -0500
Date: Thu, 5 Jan 2006 13:48:06 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: "Scott E. Preece" <preece@motorola.com>
cc: pavel@suse.cz, "" <akpm@osdl.org>, "" <linux-pm@lists.osdl.org>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <200601051516.k05FGC5d023781@olwen.urbana.css.mot.com>
Message-ID: <Pine.LNX.4.50.0601051344200.17046-100000@monsoon.he.net>
References: <200601051516.k05FGC5d023781@olwen.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Jan 2006, Scott E. Preece wrote:

> --===============26103097005026354==
>
>
> My inclination would be to have the sysfs interface know generic terms,
> with the implementation mapping them to device-specific terms. It ought
> to be possible to build portable tools that don't have to know about
> device-specific states and have the device interfaces (in sysfs) do the
> necessary translation.

Userspace should do the translation. You should give the user the ability
to specify simple, meaningful states, like "on" and "off". But, it should
be the tools itself that are mapping those requests to valid input for the
sysfs files.

Why force the translation into the kernel, and provide more opportunities
for error in parsing the sysfs files? Do it in userspace, and you can
afford much more flexibility and portability.

Thanks,


	Patrick

