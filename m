Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbTGDPmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 11:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266057AbTGDPmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 11:42:51 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:34045 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S266054AbTGDPmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 11:42:50 -0400
Message-ID: <3F05A4C8.9060604@pacbell.net>
Date: Fri, 04 Jul 2003 09:01:12 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: "Ilia A. Petrov" <masmas@mcst.ru>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] PROBLEM: when booting from USB-HDD device kernel
 2.4.21 is trying to mount root file system too early before usb device is
 found on the usb-bus
References: <3F056D0D.3050101@mcst.ru>
In-Reply-To: <3F056D0D.3050101@mcst.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ilia A. Petrov wrote:
> When kernel is mounting root file system it is doing it too fast so 
> usb-support have not ime to scan bus for mass-storage devices and 
> connect them.
> ...
> or, imho better way, - when completing init of usb bus, first scans it 
> and connect all devices and only after all devices were connected 
> returns to main kernel code.

That might not entirely solve the problem, since the relevant device
could drop off the bus temporarily, but it seems like it'd be a step
forward.  How would you make root hub ("bus") initialization do that?

- Dave


