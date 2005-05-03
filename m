Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVECBp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVECBp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 21:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVECBp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 21:45:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25498 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261283AbVECBpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 21:45:20 -0400
Date: Tue, 3 May 2005 02:45:43 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: jdike@addtoit.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/22] UML - Include the linker script rather than symlink it
Message-ID: <20050503014543.GD18977@parcelfarce.linux.theplanet.co.uk>
References: <200505012112.j41LC9fa016385@ccure.user-mode-linux.org> <20050502170654.248b11ea.akpm@osdl.org> <20050503002521.GA18977@parcelfarce.linux.theplanet.co.uk> <20050502174405.0c8cad31.akpm@osdl.org> <20050503011744.GC18977@parcelfarce.linux.theplanet.co.uk> <20050502182851.27f22470.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502182851.27f22470.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 06:28:51PM -0700, Andrew Morton wrote:
> # Copyright 2003 - 2004 Pathscale, Inc
> # Released under the GPL
> 
> hostprogs-y	:= mk_sc mk_thread
> always		:= $(hostprogs-y)
> 
> HOSTCFLAGS_mk_thread.o := -I$(objtree)/arch/um
 
> Is mk_sc still supposed to be in there?

Yes, along with hostflags for it.

> > how the hell did the latter manage to apply at all?)
> 
> I just "fixed" things.  I do it all the time.

Erm...  "Gives rejects" => "ought to investigate" => "bugger it, let
submitter figure it out and resubmit" would be an obvious progression...

OK.  Please, pick the following patches:
UM0-uml-ldscript-RC12-rc3
UM1-uml-os-RC12-rc3
UM2-uml-user-constants-RC12-rc3
UM3-uml-ptregs-RC12-rc3
UM4-uml-sc-RC12-rc3
UM5-uml-kernel-offsets-RC12-rc3
UM6-uml-thread-RC12-rc3
UM7-uml-util-RC12-rc3
UM8-uml-clean-RC12-rc3
UM10-uml-O-RC12-rc3
in ftp.linux.org.uk/pub/people/viro.  In the order above.  That's where
the beginning of Jeff's series had come from (his 1--9 and 4.5).

(In case if you wonder about UM9, that one already has an equivalent in
-mm).


