Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWHBQoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWHBQoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWHBQoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:44:11 -0400
Received: from mail.tmr.com ([64.65.253.246]:62401 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S932101AbWHBQoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:44:09 -0400
Message-ID: <44D0D718.5050505@tmr.com>
Date: Wed, 02 Aug 2006 12:47:20 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
Newsgroups: gmane.linux.raid,gmane.linux.kernel
To: Alexandre Oliva <aoliva@redhat.com>
CC: Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: let md auto-detect 128+ raid members, fix potential race condition
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br>	<20060730124139.45861b47.akpm@osdl.org>	<orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br>	<17613.16090.470524.736889@cse.unsw.edu.au> <44CF9221.90902@tmr.com> <orlkq8f8ge.fsf@free.oliva.athome.lsd.ic.unicamp.br>
In-Reply-To: <orlkq8f8ge.fsf@free.oliva.athome.lsd.ic.unicamp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Oliva wrote:
> On Aug  1, 2006, Bill Davidsen <davidsen@tmr.com> wrote:
> 
>> I rarely think you are totally wrong about anything RAID, but I do
>> believe you have missed the point of autodetect. It is intended to
>> work as it does now, building the array without depending on some user
>> level functionality.
> 
> Well, it clearly depends on at least some user level functionality
> (the ioctl that triggers autodetect).  Going from that to a
> full-fledged mdadm doesn't sound like such a big deal to me.
> 
>> I don't personally see the value of autodetect for putting together
>> the huge number of drives people configure. I see this as a way to
>> improve boot reliability, if someone needs 64 drives for root and
>> boot, they need to read a few essays on filesystem
>> configuration. However, I'm aware that there are some really bizarre
>> special cases out there.
> 
> There's LVM.  If you have to keep root out of the VG just because
> people say so, you lose lots of benefits from LVM, such as being able
> to grow root with the system running, take snapshots of root, etc.
> 
But it's MY system. I don't have to anything. More to the point, growing 
root while the system is running is done a lot less than booting. In 
general the root f/s has very little in it, and that's a good thing.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
