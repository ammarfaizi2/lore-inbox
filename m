Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267568AbSKQTyN>; Sun, 17 Nov 2002 14:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267569AbSKQTyN>; Sun, 17 Nov 2002 14:54:13 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13958 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267568AbSKQTyM>;
	Sun, 17 Nov 2002 14:54:12 -0500
Date: Sun, 17 Nov 2002 15:01:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Doug Ledford <dledford@redhat.com>
cc: Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why /dev/sdc1 doesn't show up...
In-Reply-To: <20021117195258.GC3280@redhat.com>
Message-ID: <Pine.GSO.4.21.0211171457290.23400-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Nov 2002, Doug Ledford wrote:

> in scsi_module.c works, but is too ugly to live (and totally defeats the
> purpose of the new module loading code anyway).  Oh, and all the high

There is a purpose?  Seriously, "no use of ones object during init" is
WRONG.  Rusty, remember I've told you that block devices need to be
able to open() during init?  That's what it is.

We _might_ eventually kludge around that, but IMO the ->live checks on
the init side are just plain wrong.

