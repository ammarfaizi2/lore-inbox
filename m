Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVAPUNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVAPUNk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVAPUNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:13:40 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:52867 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S262578AbVAPUNe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:13:34 -0500
Message-ID: <41EACAE9.9090505@cwazy.co.uk>
Date: Sun, 16 Jan 2005 15:13:29 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       akpm@osdl.org
Subject: Re: [PATCH 0/13] remove cli()/sti() in drivers/char/*
References: <20050116135223.30109.26479.55757@localhost.localdomain> <41EABFC5.3060002@osdl.org>
In-Reply-To: <41EABFC5.3060002@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 14:13:30 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> James Nelson wrote:
> 
>> This series of patches removes the last 
>> cli()/sti()/save_flags()/restore_flags()
>> function calls in drivers/char.
> 
> 
> to what end?
> 
> I guess I don't get it.  What makes these drivers SMP-safe now?
> 
> Or is this series of patches only done to kill off the use
> of deprecated functions?  If that's the case, they could
> easily give someone the (false) expectation that the drivers
> are SMP-safe, couldn't they?  Well, ftape (for one) is still
> marked as BROKEN_ON_SMP, but will people know why it's
> marked that way?
> 
> Have you read Documentation/cli-sti-removal.txt ?
> 
I have.  This is just to get rid of the deprecated functions - most of this stuff 
is already marked BROKEN_ON_SMP (stallion, serial_tx3912, epca, esp, istallion, 
riscom8, ftape, pcxx and moxa), and ite_gpio.c is a driver for a UP system board.

Maybe later (when I have more of an understanding of serial_core, and major driver 
overhaul) I can tackle actually fixing them, but right now, I'm just doing cleanup 
work.

Jim
