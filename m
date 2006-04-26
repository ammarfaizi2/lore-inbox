Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWDZSI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWDZSI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWDZSI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:08:56 -0400
Received: from mail1.skjellin.no ([80.239.42.67]:21226 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S932364AbWDZSIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:08:55 -0400
Message-ID: <444FB742.40604@tomt.net>
Date: Wed, 26 Apr 2006 20:09:06 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Nick Warne <nick@linicks.net>, Jens Axboe <axboe@suse.de>
Subject: Re: scheduler question 2.6.16.x
References: <200604251905.19004.nick@linicks.net> <20060425181530.GQ4102@suse.de> <200604251933.48363.nick@linicks.net>
In-Reply-To: <200604251933.48363.nick@linicks.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:
> On Tuesday 25 April 2006 19:15, Jens Axboe wrote:
> 
>>> But I can build both in... so I guess then the kernel decides what is
>>> the best to use?  Or should it be so I am only allowed to select one
>>> or the other and allowing both is an oversight?
>> See the option no more than two lines down from that, default io
>> scheduler. Also see Documentation/block/switching-sched.txt and/or
>> Documentation/kernel-parameters.txt (elevator=) section.
> 
> Hi Jens,
> 
> I haven't got the switching-sched.txt, although I found a sched-design.txt... 
> but what I meant was if I select whatever default, do/can I still need to 
> select either/or scheduler?
> 
> i.e. why doesn't 'default selection option' only allow that scheduler to be 
> selected?

That would be a artificial (and silly!) limit - the io-scheduler is 
pluggable and selectable at boot, you can even change it at run time at 
a per block device level.

See the elevator= boot option and /sys/block/<device>/queue/scheduler
