Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318536AbSIKIc1>; Wed, 11 Sep 2002 04:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318539AbSIKIc1>; Wed, 11 Sep 2002 04:32:27 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:43648 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S318536AbSIKIc0>;
	Wed, 11 Sep 2002 04:32:26 -0400
Date: Wed, 11 Sep 2002 03:36:16 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.34-bk floppy weirdness
In-Reply-To: <200209110825.KAA06080@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0209110334100.9324-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2002, Mikael Pettersson wrote:

> >dd: opening `/dev/fd0': No such device or address
> >[tmolina@dad testfloppystable]$ su
> >Password:
> >[root@dad testfloppystable]# dd if=floppyimage of=/dev/fd0
> >2880+0 records in
> >2880+0 records out
> 
> My 2.5.34 (proper, not bk) doesn't have this misbehaviour.
> 
> Are you building the floppy driver as a module and relying
> on kmod+modutils to insert it on demand? If so, you may be
> seeing the same problem I was when I upgraded my user-space
> to RedHat 7.3: dd of=/dev/fd0 as a user won't load floppy.o.
> See RedHat bug id 65685 for details.

You are exactly right.  The floppy driver is built as a module.  I'll 
refer to the bugzilla and add a comment if needed.  Since this is a 
RedHat-specific symptom I'll handle it through them.

