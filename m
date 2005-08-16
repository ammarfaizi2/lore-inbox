Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbVHPSF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbVHPSF1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbVHPSF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:05:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10136 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030272AbVHPSF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:05:26 -0400
Date: Tue, 16 Aug 2005 11:05:20 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: jerome lacoste <jerome.lacoste@gmail.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       Marie-Helene Lacoste <manies@tele2.fr>
Subject: Re: 2.6.12.3 clock drifting twice too fast (amd64)
In-Reply-To: <5a2cf1f6050816031011590972@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0508161103360.7101@schroedinger.engr.sgi.com>
References: <5a2cf1f6050816031011590972@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005, jerome lacoste wrote:

> Installed stock 2.6.12.3 on a brand new amd64 box with an Asus extreme
> AX 300 SE/t mainboard.
> 
> I remember seeing a message in the boot saying something along:
> 
>   "cannot connect to hardware clock."
> 
> And now I see that the time is changing too fast (about 2 seconds each second).

The timer interrupt is probably called twice for some reason and therefore 
time runs twice as fast. Try using HPET for interrupt timing.

> I don't have visual on the boot sequence anymore (only remote access).

Use serial console or netconsole. The boot information is logged. Try 
dmesg.
