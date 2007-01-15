Return-Path: <linux-kernel-owner+w=401wt.eu-S1750849AbXAORyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbXAORyh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbXAORyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:54:37 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:45724 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbXAORyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:54:36 -0500
Date: Mon, 15 Jan 2007 18:54:37 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Andrew Walrond <andrew@walrond.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Initramfs and /sbin/hotplug fun
Message-ID: <20070115175437.GA26944@aepfle.de>
References: <45AB8CB9.2000209@walrond.org> <20070115170412.GA26414@aepfle.de> <45ABBB8B.6000505@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45ABBB8B.6000505@walrond.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, Andrew Walrond wrote:

> >/sbin/hotplug and /init are two very different and unrelated things.
> 
> Well, of course. But looking at the thread provided by Jan, it seems the 
> kernel might not be in any fit state to service the (userspace) hotplug 
> infrastructure when it makes the calls (Ie can't create pipes yet).

Thats because noone really fixed the init call order. Its going back and
forth since /init was added in 2.6.6.
Ideally, there could be some /earlyinit that could prepare the
enviroment for hotplug calls.
Why do you need /sbin/hotplug anyway, just for firmware loading for a
non-modular kernel?
