Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbSK1AVO>; Wed, 27 Nov 2002 19:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbSK1AVN>; Wed, 27 Nov 2002 19:21:13 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:37513 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264975AbSK1AVN>; Wed, 27 Nov 2002 19:21:13 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 27 Nov 2002 16:25:50 -0800
Message-Id: <200211280025.QAA07845@baldur.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Modules with list
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz, zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russel wrote:
>In message <200211270722.XAA23313@adam.yggdrasil.com> you write:
>> Rusty Russell wrote:
>> >In message <200211260649.WAA22216@adam.yggdrasil.com> you write:
>> >> >This would only happen if someone says "rmmod --wait".
>> 
>> >As I realized last night after I wrote this, there is a bug in
>> >module.c.  If O_NONBLOCK is specified, we shouldn't drop the module
>> >sempaphore at all, for exactly this reason.  A bug I introduced while
>> >"cleaning up" the "--wait" path.
>> 
>> >Sorry for the confusion.
>> 
>> 	Then if you do "rmmod --wait" on some module that is in use,
>> every lsmod, insmod and rmmod will hang while attempting to acquire

>Sorry, that's why I said "*If O_NONBLOCK* is specified" (ie. still
>drop it for the --wait case).

	Oops!  Sorry for misreading your message.

	Even though it was not responsive to what you described, I do
hope you see my point about the problem with "rmmod --wait".

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
