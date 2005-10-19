Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVJSIV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVJSIV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 04:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVJSIV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 04:21:26 -0400
Received: from barad-dur.crans.org ([138.231.141.187]:37816 "EHLO
	barad-dur.minas-morgul.org") by vger.kernel.org with ESMTP
	id S932411AbVJSIV0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 04:21:26 -0400
From: "Mathieu Segaud" <matt@regala.cx>
To: Greg KH <greg@kroah.com>
Cc: Aaron Gyes <floam@sh.nu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1: udev/sysfs wierdness
References: <1129610113.10504.4.camel@localhost>
	<20051018055003.GA10488@kroah.com> <20051018065705.GA11858@kroah.com>
	<87r7ajdy4v.fsf@barad-dur.minas-morgul.org>
	<20051019034427.GA15940@kroah.com>
X-PGP-KeyID: 0x2E13FCA8
X-PGP-Fingerprint: D41C FC4F 7374 D3FA A121 9182 90AC 62B0 2E13 FCA8
Date: Wed, 19 Oct 2005 10:21:25 +0200
In-Reply-To: <20051019034427.GA15940@kroah.com> (Greg KH's message of "Tue, 18
	Oct 2005 20:44:27 -0700")
Message-ID: <87br1lex2y.fsf@barad-dur.minas-morgul.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> disait dernièrement que :

> On Tue, Oct 18, 2005 at 10:31:44AM +0200, Mathieu Segaud wrote:
>> Greg KH <greg@kroah.com> disait derni??rement que :
>> 
>> > On Mon, Oct 17, 2005 at 10:50:03PM -0700, Greg KH wrote:
>> >> On Mon, Oct 17, 2005 at 09:35:13PM -0700, Aaron Gyes wrote:
>> >> > For some reason this rule stopped working:
>> >> > 
>> >> > KERNEL=="event*", SYSFS{manufacturer}="Logitech", SYSFS{product}="USB
>> >> > Receiver", NAME="input/mx1000", MODE="0644"
>> >> > 
>> >> > Did stuff in /sys/ change? Do I need to change all my rules to make up
>> >> > for this? udevs fault? I do have the correct /dev/input/event0 node.
>> >> 
>> >> You have that node?  That's a good start :)
>> >> 
>> >> I think the "name" might have changed, it looks like I messed that up
>> >> somehow.  What does:
>> >> 	 udevinfo -p /sys/class/input/input0/event0/ -a
>> >> 
>> >> show (or whatever that sysfs path is.)
>> >> 
>> >> Oops, heh, that dies on my box too.  Ok, I think that's the issue,
>> >> sorry.  I'm working on it...
>> >
>> > Can you try the patch below to see if that fixes the issue?  That should
>> > keep udevinfo from dieing.
>> 
>> huh, it doesn't apply to 2.6.14-rc4-mm1....
>> for which tree is it exactly ?
>> 
>> patching file drivers/input/input.c
>> Hunk #1 succeeded at 641 (offset 119 lines).
>> Hunk #2 FAILED at 818.
>> Hunk #3 succeeded at 769 (offset 33 lines).
>> 1 out of 3 hunks FAILED -- saving rejects to file drivers/input/input.c.rej
>
> I was against my latest tree, which is on kernel.org.  Someone already
> posted an updated patch on lkml if you can't get that second hunk to
> apply.

I made it apply :)
thanks, I was just wondering if some bot had put an email into the
chaos-bin. It solved the problems with udevinfo as expected. Thanks a
lot.

-- 
Mathieu
