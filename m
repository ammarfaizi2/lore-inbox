Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261478AbREQSkT>; Thu, 17 May 2001 14:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbREQSkJ>; Thu, 17 May 2001 14:40:09 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:42436 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S261478AbREQSjx>; Thu, 17 May 2001 14:39:53 -0400
Date: Thu, 17 May 2001 13:39:53 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105152317.f4FNHsY3022099@webber.adilger.int>
Message-ID: <Pine.LNX.4.33.0105171310180.32079-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the risk of offending hundreds, I'll mention that dynamic naming of
disks and tapes has worked very well for many years in VMS.  When you e.g.
mount a disk volume labelled FOO, the system creates a system logical name
DISK$FOO: for it automagically.  Users don't care that it's really
$4$DUA7: (which is *really* disk#5 on one HSCxx controller and disk#2 on
another one).  When you open DISK$FOO:[some.where]some.file , the kernel
knows what you meant.

Substitute ephemeral device special files for the system logical names and
you've got something like what's being discussed here.

Mind you, when that AI-thingy, I forget the name, suspects an impending
failure and wants to send me mail about it, *it* needs some way to tell me
which physical device needs replacing, so that I don't remove the wrong
one.  So physical locations have value, but only in special circumstances.
Ordinary end-use and daily system administration shouldn't employ them.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Make a good day.

