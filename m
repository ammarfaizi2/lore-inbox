Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbSKDRow>; Mon, 4 Nov 2002 12:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262212AbSKDRov>; Mon, 4 Nov 2002 12:44:51 -0500
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:57801 "EHLO
	mhw.ulib.iupui.edu") by vger.kernel.org with ESMTP
	id <S262198AbSKDRov>; Mon, 4 Nov 2002 12:44:51 -0500
Date: Mon, 4 Nov 2002 12:51:25 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <20021101232555.GA6413@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.LNX.4.33.0211041239040.2385-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Jan Harkes wrote:
[snip]
> In the end I believe capabilities (like setuid) should be a local
> decision. Yes, I'm looking at this from the viewpoint of a distributed
> network filesystem that crosses administrative boundaries, and as such I
> don't always trust whatever is stored in a mounted volume.
>
> Why not modify a program like sudo or super that can give capabilities
> to processes based on local rules and configuration... Ok there already
> is a programs that does something like this which is called 'whichcap'.
>
> Another solution is to have a trusted daemon that is the only process
> in the system with the capability to grant capabilities to other
> proceses. Other processes can send a request to this daemon, which can
> consult local rules, double check md5 checksum or whatever paranoia is
> needed before it actually does a setcap.

You might want to look at the VMS model.  The sysadmin creates a startup
script that tells the kernel which files are to be granted "amplified
privileges" when activated.  There's a dab of kernel code to maintain and
implement this list, but there's zero filesystem code involved because
these are not metadata.  The kernel holds each "installed" file open as
long as it's installed, so there's NO way to replace a trusted file
without admin. priv.s -- you have to uninstall the file before you can
monkey with it, and there's a priv.  which controls the ability to do
that.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
MS Windows *is* user-friendly, but only for certain values of "user".

