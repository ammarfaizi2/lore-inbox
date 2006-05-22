Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWEVS5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWEVS5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWEVS5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:57:12 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:948 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750813AbWEVS5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:57:12 -0400
Date: Mon, 22 May 2006 20:56:50 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Valdis.Kletnieks@vt.edu
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add user taint flag
In-Reply-To: <200605221429.k4METL5D011740@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.61.0605222055420.4309@yvahk01.tjqt.qr>
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
 <1148307276.3902.71.camel@laptopd505.fenrus.org>           
 <1148308548.17376.44.camel@localhost.localdomain>
 <200605221429.k4METL5D011740@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > we should then patch the /dev/mem driver or something to set this :)
>> > (well and possibly give it an exception for now for PCI space until the
>> > X people fix their stuff to use the proper sysfs stuff)
>> 
>> /dev/mem is used for all sorts of sane things including DMIdecode.
>> Tainting on it isn't terribly useful. Mind you this whole user taint
>> patch seems bogus as it can only be set by root owned processes so
>> doesn't appear to do the job it is intended for - perhaps Ted can
>> explain ?
>
>Taint on write to /dev/mem, perhaps?  I don't think DMIdecode needs to
>scribble on /dev/mem, does it?  (Figure if a userspace program runs OK
>
lm-sensors looks like it pokes (writes) to /dev/mem trying to figure out 
some devices.

>on a recent Fedora or RedHat kernel, it doesn't need to scribble on /dev/mem
>too much, because the vast majority of it is lopped out via a patch....)
>
And what about /dev/port? That can also screw up things, so should probably 
be included in the taint unless I am missing something.



Jan Engelhardt
-- 
