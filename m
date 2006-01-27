Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWA0VfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWA0VfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 16:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWA0VfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 16:35:00 -0500
Received: from [217.157.19.70] ([217.157.19.70]:14554 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S932502AbWA0VfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 16:35:00 -0500
Date: Fri, 27 Jan 2006 21:33:56 +0000 (GMT)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Linus Torvalds <torvalds@osdl.org>
cc: Chase Venters <chase.venters@clientec.com>,
       "linux-os \\\(Dick Johnson\\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>
Message-ID: <Pine.LNX.4.40.0601272112590.29965-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2006, Linus Torvalds wrote:

> And quite frankly, I don't see that changing. I think it's insane to
> require people to make their private signing keys available, for example.
> I wouldn't do it.

Linus, I think you are missing the point here. I see this provision as one
of the most important fixes in GPL v3. It might not be perfect in the way
it is presented in the draft, but the rationale is certainly laudable.

This closes a very serious loophole, that in certain situations renders
the GPLv2 almost worthless. The problem is embedded systems, but
especially cellphones.

A typical smartphone has a baseband processor (running the GSM stack under
a proprietary OS - let's call it the Baseband OS) and an application
processor (running the PDA features and GUI, for example Symbian OS or
Linux, let's call it the Application OS). Newer phones use a microkernel
architecture where the two OS's each run as tasks under a microkernel so
that a single CPU can be shared, but that's not relevant for this point.

The practice for many phone manufacturers is to heavily encrypt and sign
all ROM images that go on the phone. They do this for several reasons, but
mostly to prevent end-users from modifying the baseband code (where things
like SIM-locks and network locks are stored) or changing the IMEI number
of stolen phones.

However, most manufacturers extend this protectin to also encompass the
PDA-side code. This is understandable (to an extent) where the operating
system is proprietary or licensed (e.g. Symbian OS) and not available for
end-users to modify in any case.

But when Linux is used instead (something that most major handset
manufacturers are working on at the moment), this whole picture changes.
Suddenly the whole point of "Free Software" goes away. Because the handset
manufacturer modifies, adapts and uses the Linux kernel (for free),
without having to give anything back to the community. Yes, they have to
make their modified source available, but there is no way a casual user
(read: someone not a member of the phone-unlocking mafia) can update the
kernel with a modified, recompiled version.

But it goes further. The manufacturer is free to embed "trusted
computing" technology into the kernel (e.g. digital signing of all
executables that can run on the phone), as long as the encryption
technology is included in the kernel (they can even embed the
public key in the published sources, and you have no way of
obtaining the secret key) - thereby preventing the user from running ANY
code on the phone not pre-approved by the manufacturer.

Their main motivation for doing this is basically to protect the mobile
network operators' revenue, by preventing (or at least limiting)
installation of things such as VoIP clients and instant messenger systems
that could lead towards an "open TCP/IP" infrastructure that all the
operators fear so much.

The prime example of this is what is already implemented is Symbian OS. In
Version 9, used by the latest handsets from Nokia and Sony Ericsson, it is
impossible to install applications that are not signed by an independent
testing house, something that effectively locks small businesses and
independent hobby coders out of the market. There are even certain
"capabilities", needed for example to implement networking protocols, that
can only be signed if approved by the phone manufacturer.

The only way to prevent Linux from being abused in this way is to require
that the end-users have a method of installing the modified code on the
device for which it was intended (such as your phone). If they don't want
to disclose their primary signing keys, fine, but then they need to make
another method available of replacing any free software used in the device
with a modified (by the end-user) version. I understand the need to
protect the non-GPL'ed "baseband" OS from tampering, but it has to be
possible to replace the GPL'ed software. This is what this provision is
all about (for me), and I think it is an extremely important one.

Of course I have focused on cellphones, but the same is equally true for
other embedded devices, such as digital TV boxes (e.g. PVR's). If I want
to add a nice feature (and share the patch with my friends who bought the
same box) I should be free to do so. Isn't that what Free Software is all
about?

Thomas


