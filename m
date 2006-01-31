Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWAaUIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWAaUIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWAaUIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:08:40 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:36111 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751448AbWAaUIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:08:40 -0500
Date: Tue, 31 Jan 2006 21:08:35 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Massimo De Beni <maxdb82@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Make my own modules for kernel 2.4.32
Message-ID: <20060131200835.GA7142@w.ods.org>
References: <f4fb6a4d0601310239o5cf95887y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4fb6a4d0601310239o5cf95887y@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 31, 2006 at 11:39:25AM +0100, Massimo De Beni wrote:
> Hi all,
> I'm a newbye to kernel 'modding' and I've a question that may seems
> outdated... The situation is this:
> I worked to get a Set Top Box to work with the latest stable 2.4
> kernel, the way is clear but the box need some modules to be loaded at
> boot in order to get the video and audio device to work (modules that
> are not shipped in kernels 2.4...); now I'm building those modules
> separatly, compiling directly the drivers source codes with 'make',
> and then I insert the .o with 'insmod'.
> I would create a better system in which one could compile those
> modules directly on the 'make menuconfig' of the kernel, so I'm
> modifying the various Makefiles && config files, but I'm a bit
> confused... Any good hint?

You have to add an 'obj-m' entry to the Makefile located in the same
directory as your driver, and make it depend on an option which will
be enabled in some Config.in (in the same directory if possible).
You should look at any driver provided as a patch for the kernel, it
will be fairly easier for you to understand what they touch. And don't
forget one important thing : always ensure that the kernel still builds
with your module disabled. Also, don't forget to add an entry in the
Configure.help file.

> Thanks in advance...!

Regards,
Willy

