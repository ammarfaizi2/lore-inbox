Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266049AbUFVWOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUFVWOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 18:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUFVWNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 18:13:02 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:55546 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265737AbUFVWKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 18:10:36 -0400
Date: Tue, 22 Jun 2004 18:04:28 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: Improve Kernel build with separated output
In-Reply-To: <20040622212100.GA9346@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.33.0406221749270.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004, Sam Ravnborg wrote:
>1) A Makefile is generated in the output directory allowing
>   one to execute make in both the source and the output directory.

I would vote against doing that.  Or at the very least don't overwrite one
that might already be there.  I, for one, have a very specific makefile in
my build (object) directories.  Anyone sufficiently skilled to be building
kernels outside the source tree, and/or those with the specific need to be
doing so will already have makefiles and/or shell scripts to suit their
needs.  Making the option a user specified target ala "make makefiles"
would be a better/safer choice; if the user wants or needs a makefile in
their object directory, then they have a simple option to make themselves
one -- no knowledge of GNU Make necessary.

And in my case(s), the source and object symlinks will be of no value.  The
next "bk pull" and build invalidates those links.  And once the kernel(s)
are installed on their respective target machines, there won't be any
source or object trees.

--Ricky


