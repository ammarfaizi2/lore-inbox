Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268407AbUH2X3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268407AbUH2X3J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 19:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUH2X3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 19:29:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15592 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268399AbUH2X27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 19:28:59 -0400
Date: Mon, 30 Aug 2004 00:28:56 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Grzegorz Kulewski <kangur@polcom.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040829232856.GC16297@parcelfarce.linux.theplanet.co.uk>
References: <20040827230857.69340aec.pj@sgi.com> <20040829150231.GE9471@alias> <4132205A.9080505@namesys.com> <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk> <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk> <41323751.5000607@namesys.com> <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org> <Pine.LNX.4.60.0408300009001.10533@alpha.polcom.net> <Pine.LNX.4.58.0408291523130.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408291523130.2295@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 03:37:16PM -0700, Linus Torvalds wrote:
> > Sorry if my qestion is stupid, but why can't we deal with (hard)links to 
> > directories in (nearly) same way we deal with bind mounts (= making 
> > exactly one object representing target and only referencing to it)?
> 
> On a VFS level we could, these days, I think. But realize that bind mounts
> and the vfsmounts are pretty recent things.
 
Bindings won't replace hardlinks.
	a) lifetime rules and keeping stuff busy
	b) who's bound on top?  Note that for real hardlinks to directories
(not just "directory on top of file" hybrids) it's a serious question
	c) for real hardlinks we would want at least rename() working
