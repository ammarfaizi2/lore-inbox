Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTEVAA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 20:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbTEVAA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 20:00:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45770 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262400AbTEVAA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 20:00:56 -0400
Date: Thu, 22 May 2003 01:13:58 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Robert White <rwhite@casabyte.com>
Cc: root@chaos.analogic.com, Helge Hafting <helgehaf@aitel.hist.no>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: recursive spinlocks. Shoot.
Message-ID: <20030522001358.GB14406@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.53.0305210940160.3520@chaos> <PEEPIDHAKMCGHDBJLHKGGEHPCMAA.rwhite@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGGEHPCMAA.rwhite@casabyte.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 02:56:12PM -0700, Robert White wrote:
> Lets say I have a file system with a perfectly implemented unlink and a
> perfectly implemented rename.  Both of these routines need to exist exactly
> as they are.  Both of these routines need to lock the vfs dentry subsystem
> (look it up.)

_Do_ look it up.  Neither ->unlink() nor ->rename() need to do anything with
any sort of dentry locking or modifications.

Illustrates the point rather nicely, doesn't it?  What was that about
taking locks out of laziness and ignorance, again?  2%?  You really
like to feel yourself a member of select group...

Unfortunately, that group is nowhere near that select - look up the
Sturgeon's Law somewhere.  90% of anything and all such...
