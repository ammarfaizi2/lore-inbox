Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264108AbUE2Ial@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbUE2Ial (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 04:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbUE2Iai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 04:30:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5856 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264108AbUE2IaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 04:30:20 -0400
Date: Sat, 29 May 2004 10:30:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org,
       Gunther Persoons <gunther_persoons@spymac.com>
Subject: Re: [2.6.7-rc1-mm1] cant mount reiserfs using -o barrier=flush
Message-ID: <20040529083013.GS20657@suse.de>
References: <1085689455.7831.8.camel@localhost> <40B72886.3000507@spymac.com> <20040528121822.GH20657@suse.de> <200405281739.53892.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405281739.53892.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28 2004, Ed Tomlinson wrote:
> On May 28, 2004 08:18 am, Jens Axboe wrote:
> > error=0x04 is an aborted command, meaning it's not supported. So
> > ide-disk dumps that message to the log (barrier support doesn't work)
> > and turns it off. This is expected behaviour if your drive doesn't
> > support cache flushing.
> 
> Then I would expect to see the message _once_.   In my case I have 8
> entries with these errors in my logs (then I rebooted).  Once would not 
> be bad but 8 indicates to me that something is not respecting the flag
> (or its being reset).
> 

It's possible to get more than 1, if you get a bunch of barriers queued
before the flag has a chance to catch them at submission. If you could
send me a log of what happens (what you did and the kernel messages), I
can take a look.

-- 
Jens Axboe

