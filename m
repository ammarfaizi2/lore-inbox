Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbUKDUXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbUKDUXA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbUKDUT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:19:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28072 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262403AbUKDUPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:15:14 -0500
Date: Thu, 4 Nov 2004 12:14:32 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: 2.6.9 USB storage problems
Message-ID: <20041104121432.64d2d7fc@lembas.zaitcev.lan>
In-Reply-To: <Pine.LNX.3.96.1041104135949.12155B-100000@gatekeeper.tmr.com>
References: <20041104011932.0b5d2aae@lembas.zaitcev.lan>
	<Pine.LNX.3.96.1041104135949.12155B-100000@gatekeeper.tmr.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004 14:04:58 -0500 (EST), Bill Davidsen <davidsen@tmr.com> wrote:

> > I thought about the coexistence between the two at some length, and it seems
> > to me that the current scheme is the simplest workable scheme. I even thought
> > it as "least confusing" until messages from Wolfgang and others made it clear
> > that relationship between ub and usb-storage is not obvious enough to them.
> > I'm always open to patches, too.
> 
> It would seem that wanting to use both flash keys and more common USB
> devices would be the common case for those who use flash keys at all.
> Would it be possible to have the regular USB drivers support the slow
> devices, if only to the extent of handing them off as they do CD, NIC, or
> disk? Or are these slow devices so unique that they are totally
> incompatible with faster devices?

It's not a question of speed, in my view, but rather the protocol.
I have a patch by Peter Jones in my queue, which allows to burn CDs
with ub, for example. But splitting a whole protocol class is difficult.
It would be great to give DVDs to usb-storage and keep hard drives
and flash keys to ub, but I don't see a good way to accomplish that.

Again, if you come up with a patch which does inquiry and somehow
arranges who handles what, it may be a good thing. But it has to pass
a test of "not introducing too much complexity for too little gain".

I understand that I am setting a situation of two drivers doing similar
thing but not quite in the same way, just like in the bad old days
of uhci and usb-uhci. My current goal is to allow all users to have ub
configured at all times, if they want to. If it didn't fail devices like
Fabio's and if burned CDs, you'd never notice that something was different,
right? If this turns out unattainable, we can always remove ub from
the tree.

-- Pete
