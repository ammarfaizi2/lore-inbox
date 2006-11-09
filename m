Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966056AbWKIUyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966056AbWKIUyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 15:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966057AbWKIUyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 15:54:35 -0500
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:16077 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S966056AbWKIUye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 15:54:34 -0500
Message-ID: <45539588.7020504@atipa.com>
Date: Thu, 09 Nov 2006 14:54:32 -0600
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Christoph Anton Mitterer <calestyo@scientia.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net> <87psbzrss2.fsf@duaron.myhome.or.jp> <4553744E.3050007@scientia.net> <45539188.5080607@atipa.com> <45539366.7070809@scientia.net>
In-Reply-To: <45539366.7070809@scientia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2006 20:55:30.0312 (UTC) FILETIME=[6428A880:01C70441]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Anton Mitterer wrote:
> Roger Heflin wrote:
>> Christoph,
>>
>> Install then edac_mc module, and make sure  through the
>> sysctl command that pci parity checking is enabled.
>>
>> I have seen pci parity errors produce this sort of results,
>> ie make 100 identical 50MB files, and cksum them and one
>> will be wrong, do it a again, and the "wrong" one is now
>> right, but someone else is "wrong".
> Ah thx,... is it in the vanilla kernel?
> And do you know of any possible results that this issue has? When I just
> read data (see my original stuff with fat32) is it possible that this
> had been modified or damaged?
> Or are the only consequences that diff errors occur?
> 
> And what is responsible for that parity errors? Is it possible that any
> hardware is damaged?

The failure can manifest itself in many ways, I have
only seen it as a read failure, but there should be no
reason why it cannot also show as a write failure.

It should be in the later vanilla kernels, it won't
be in the earlier ones,  I would do a
find /lib/modules -name "*edac*" -ls

It is a hw issue, either something is running faster that
it should be (pci bus set to fast for the given hardware/config)
or something is broken.

                          Roger
