Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVGSTXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVGSTXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 15:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVGSTXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 15:23:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65427 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262088AbVGSTWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 15:22:09 -0400
Date: Tue, 19 Jul 2005 12:22:06 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: DervishD <lkml@dervishd.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB debouncing?
Message-Id: <20050719122206.1b690f57.zaitcev@redhat.com>
In-Reply-To: <mailman.1121790540.24438.linux-kernel2news@redhat.com>
References: <mailman.1121790540.24438.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2005 18:24:25 +0200, DervishD <lkml@dervishd.net> wrote:

>     I have a new MP3 player, and when I disconnect it from the USB
> port, my logs says:
> 
>     <30>Jul 19 18:11:05 kernel: usb.c: USB disconnect on device 00:07.3-1 address 2
>     <27>Jul 19 18:11:06 kernel: hub.c: connect-debounce failed, port 1 disabled
> 
>     What is that 'connect-debounce' for? Is the port damaged? Am I
> doing anything wrong?

The ports are not getting completely disabled. The wording is poor.
If you plug something else, hub gets a connect change, khubd will
allow another debounce cycle and accept whatever happens.

In this case, when you're pulling the plug the hub receives a
momentary reconnect, so the software things something else was plugged.
I think perhaps the resistor harness is not good in the device,
or perhaps something is wrong with the connector.

-- Pete
