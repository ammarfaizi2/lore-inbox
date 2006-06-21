Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWFUBRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWFUBRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWFUBRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:17:24 -0400
Received: from gw.goop.org ([64.81.55.164]:38608 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750704AbWFUBRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:17:23 -0400
Message-ID: <44989E25.3090402@goop.org>
Date: Tue, 20 Jun 2006 18:17:25 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       jeremy@xensource.com
Subject: Re: [PATCH 2.6.17] Clean up and refactor i386 sub-architecture setup
References: <44988803.5090305@goop.org> <44988E08.9070000@vmware.com> <449891B9.3060409@goop.org> <4498958B.504@vmware.com>
In-Reply-To: <4498958B.504@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> This is cleaner than the patches I sent in March, although we want to 
> re-use parts of the mach-default code, not replace it entirely.  Hence 
> my interest in the multi-subarch generic kernel.  I'd be glad to look 
> into it.
In my current Xen patch, I split the mach-default/setup.c into setup.c 
and setup-memory.c; Xen uses setup.c as-is, and then provides its own 
setup-xen.c.  That solves my immediate problem, but I don't know if it 
generalizes enough; certainly factoring default/setup.c into a cluster 
of reusable setup-*.c pieces is a pretty lightweight way of reusing 
those pieces.

    J
