Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWCNKqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWCNKqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWCNKqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:46:21 -0500
Received: from cindy.kollegienet.dk ([130.226.80.138]:50919 "EHLO
	mail.odense.kollegienet.dk") by vger.kernel.org with ESMTP
	id S1750797AbWCNKqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:46:21 -0500
From: Elias Naur <elias@oddlabs.com>
Organization: Oddlabs ApS
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Expose input device usages to userspace
Date: Tue, 14 Mar 2006 11:46:04 +0100
User-Agent: KMail/1.8.2
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
References: <200603132154.38876.elias@oddlabs.com> <200603140821.32301.elias@oddlabs.com> <1142324558.3027.10.camel@laptopd505.fenrus.org>
In-Reply-To: <1142324558.3027.10.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603141146.04270.elias@oddlabs.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-FKO-MailScanner: No virus found
X-FKO-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.9, required 5,
	autolearn=not spam, BAYES_00 -4.90)
X-MailScanner-From: elias@oddlabs.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 09:22, Arjan van de Ven wrote:
> > > No, I don't think this is needed at all - users should be interested in
> > > what capabilities a particular device has, not what type it was
> > > assigned by soneone.
> >
> > I see your point that an application should not rely too much on device
> > usages. However, the main reason I want device usages is to help
> > applications and users identify and (visually) represent devices. For
> > example, games could show an appropriate icon graphic representing each
> > active device. The event interface already has a few other ioctls for
> > this kind of information:
>
> ok then you should consider to do it the other way around: make a way of
> asking
> "are you matching THIS profile".
> rather than
> "what profile are you"
>
> that way devices can present multiple faces etc; which is going to be
> needed as more and more weird devices come into existence.

If by profile you mean a device usage like Mouse, Keyboard, Joystick etc. is 
your proposal covered by the bit field ioctl exposed by my patch? For 
example, a device can already expose itself as both a joystick and a mouse 
(see the hid-input.c changes from the patch).

 - elias
