Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWCNK7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWCNK7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWCNK7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:59:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6586 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751016AbWCNK7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:59:13 -0500
Subject: Re: [PATCH] Expose input device usages to userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Elias Naur <elias@oddlabs.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200603141146.04270.elias@oddlabs.com>
References: <200603132154.38876.elias@oddlabs.com>
	 <200603140821.32301.elias@oddlabs.com>
	 <1142324558.3027.10.camel@laptopd505.fenrus.org>
	 <200603141146.04270.elias@oddlabs.com>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 11:59:06 +0100
Message-Id: <1142333947.3027.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 11:46 +0100, Elias Naur wrote:
> On Tuesday 14 March 2006 09:22, Arjan van de Ven wrote:
> > > > No, I don't think this is needed at all - users should be interested in
> > > > what capabilities a particular device has, not what type it was
> > > > assigned by soneone.
> > >
> > > I see your point that an application should not rely too much on device
> > > usages. However, the main reason I want device usages is to help
> > > applications and users identify and (visually) represent devices. For
> > > example, games could show an appropriate icon graphic representing each
> > > active device. The event interface already has a few other ioctls for
> > > this kind of information:
> >
> > ok then you should consider to do it the other way around: make a way of
> > asking
> > "are you matching THIS profile".
> > rather than
> > "what profile are you"
> >
> > that way devices can present multiple faces etc; which is going to be
> > needed as more and more weird devices come into existence.
> 
> If by profile you mean a device usage like Mouse, Keyboard, Joystick etc. is 
> your proposal covered by the bit field ioctl exposed by my patch? For 
> example, a device can already expose itself as both a joystick and a mouse 
> (see the hid-input.c changes from the patch).


no that's not what I meant; I really mean asking "can you do THIS
profile". Example would be a device that could be either a joystick and
a mouse, or a touchpad and a mouse, but not both a touchpad and a
joystick. So the app should ask "can you do THESE", and the driver can
then do anything complex it wants to come to an answer. (Of course a
generic helper for the simple case is fine)


