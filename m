Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUBDV0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266595AbUBDVYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:24:40 -0500
Received: from hermes.domdv.de ([193.102.202.1]:4367 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id S266566AbUBDVWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:22:42 -0500
Message-ID: <4021628D.5030805@domdv.de>
Date: Wed, 04 Feb 2004 22:22:21 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031022
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: piotr@member.fsf.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20269 (Ultra133 TX2) + Software RAID
References: <6FF5C83C-55FA-11D8-AC00-000A95CEEE4E@computeraddictions.com.au> <20040204204622.GA14326@larroy.com>
In-Reply-To: <20040204204622.GA14326@larroy.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pedro Larroy wrote:
> On Tue, Feb 03, 2004 at 02:08:31PM +1030, Ryan Verner wrote:
> 
> 
>>And the machine is randomly locking up, and of course, on reboot, the 
>>raid array is rebuilt.  Ouch.  Any clues as to why?  I'm sure the hard 
>>drive hasn't failed as it's brand new; I suspect a chipset 
>>compatibility problem or something.
>>
>>R
>>
> 
> 
> I have similar issues with 20269. I have two cards on one box doing sw raid5
> on 6 ide drives. It only runs stably with 2.4.19
> It has been many months since I assembled that box, and I've tried kernels
> from 2.4.20-ac, 2.5.x, 2.6.2  and all hang after some time running.
> 
> I remember that pdcs also hanged a dual processor box.
> 

In my case (see my mail to lkml today) I do suspect concurrent disk 
access and IO-APIC to be the culprit. If you're using an IO-APIC try 
booting with either "noapic" or "hdx=serialize" where hdx is one of the 
disks of your controller card.
-- 
Andreas Steinmetz

