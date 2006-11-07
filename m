Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753168AbWKGUa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbWKGUa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753177AbWKGUa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:30:28 -0500
Received: from mx.pathscale.com ([64.160.42.68]:47050 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1753168AbWKGUa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:30:26 -0500
Date: Tue, 7 Nov 2006 12:30:25 -0800 (PST)
From: Dave Olson <olson@pathscale.com>
Reply-To: olson@pathscale.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
In-Reply-To: <m1mz739l0b.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0611071228230.8122@topaz.pathscale.com>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
 <20061105064801.GV13381@stusta.de> <m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>
 <20061107042214.GC8099@stusta.de> <45501730.8020802@serpentine.com>
 <m1psbzbpxw.fsf@ebiederm.dsl.xmission.com> <4550B22C.1060307@serpentine.com>
 <m18xinb1qn.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0611070934570.25925@topaz.pathscale.com>
 <m1mz739l0b.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006, Eric W. Biederman wrote:
| > | If your card doesn't pay attention to configuration space access cycles then
| > | there should be no reason to write the value there.   If your card does pay
| > | attention to the configuration space access cycles it should be trivial to
| > | make this work.
| >
| > The card does pay attention, and other programs such as lspci and the
| > like also look at the config space.  They should definitely be kept
| > in sync, and config writes are fairly cheap, anyway.
| 
| Well this is a rathole so it really isn't safe for lspci to play with
| (races with the kernel accessing it)

Displaying something that might change is a fact of life, and no
different than the PCI world.  It's still best to keep things as
correct as possible.

| This hole concept of you having the register but not connecting it up on
| the card is rather bizarre.

The HT core we use made it extremely difficult, unfortunately.   One of
those things in hardware you sometimes just have to live with.

| > The HT layer should always do the config updates, since you are trying
| > to clean up that layer.  Only the "extra" stuff (if any) should be done by
| > the callback.
| 
| Fine by me.  That's why the patch was up for review.  That is just moving
| the if statement I currently have.  So it should be trivial.  If that
| won't break your card that is good enough for me.

Thanks,

Dave Olson
dave.olson@qlogic.com
