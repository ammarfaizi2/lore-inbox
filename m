Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288420AbSBDEmV>; Sun, 3 Feb 2002 23:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288512AbSBDEmI>; Sun, 3 Feb 2002 23:42:08 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:12931 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S288498AbSBDElr>;
	Sun, 3 Feb 2002 23:41:47 -0500
Date: Sun, 3 Feb 2002 23:41:47 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: <linux-kernel@vger.kernel.org>
Subject: Asynchronous CDROM Events in Userland
Message-ID: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any way, other than by polling, to have a user process be
notified of a change in status on a cdrom drive?  (Such as if the drive
opens, closes, gets new media, etc)?

Also, come think of it, other types of asynchronous events would be nice
too, like when a cdrom usb device gets hot-plugged into the system, etc.

The current ioctls are inadequate for this type of thing (they are
synchronous in nature). One nice thing would be if we can register SIGUSR
or other types of signals with the cdrom driver(s) so that it can notify a
user process of (cdrom) events it may be interested in.

The reason I ask this is that the current autorun program that comes with
kde is very inefficient because it polls the cdrom drives.  Also, this
program is completely unable to determine that a usb device has come
online, because it basically can't differentiate between bogus /etc/fstab
entries and offline usb devices.

At any rate, if anyone can suggest a way to asynchronously receive cdrom
events in userland, it would be appreciated.

If not what do you guys think about extensions to the cdrom drivers to
handle these types of things?


