Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbWICAAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbWICAAl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 20:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWICAAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 20:00:41 -0400
Received: from gw.goop.org ([64.81.55.164]:28086 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751762AbWICAAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 20:00:40 -0400
Message-ID: <44FA1B28.7010903@goop.org>
Date: Sat, 02 Sep 2006 17:00:40 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpu_init is called during resume
References: <20060831135545.GM3923@elf.ucw.cz> <44F70A4B.4090803@goop.org> <20060831223121.GG12847@elf.ucw.cz> <44F7764A.7060707@goop.org> <20060902112116.GD1178@elf.ucw.cz>
In-Reply-To: <20060902112116.GD1178@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> I think gdt is destroyed on cpu unplug, no? I guess I'll have to redo
> my testing...
>   

No, I don't think it is.  arch/i386/cpu/common.c:cpu_uninit() doesn't 
free anything.

    J

-- 
VGER BF report: H 0
