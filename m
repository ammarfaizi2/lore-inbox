Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUFPRbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUFPRbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUFPRbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:31:04 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:62663 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S264265AbUFPRa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 13:30:59 -0400
Message-ID: <40D08425.9BAC3564@users.sourceforge.net>
Date: Wed, 16 Jun 2004 20:32:21 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 5/5] kbuild: external module build doc
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204809.GF15243@mars.ravnborg.org> <40CF4C48.5A317311@users.sourceforge.net> <20040615195542.GE2310@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Tue, Jun 15, 2004 at 10:21:44PM +0300, Jari Ruusu wrote:
> > Sam, You don't seem to have any idea how much breakage you introduce if you
> > insist on redirecting the 'build' symlink from source tree to object tree.
> 
> No - and I still do not see it.

If you don't understand how many external packages depend on the 'build'
symlink pointing to directory where toplevel kernel Makefile is, then may I
suggest that you do NOT touch that symlink all.

> Please explain how we can be backward
> compatible when vendors start utilising separate directories for src and output.

Most backward compatible way is to leave the 'build' symlink alone, and add
another /lib/modules/`uname -r`/object symlink that points to the object
tree.

> Anyway, after I gave it some extra thoughs I concluded that
> /lib/modules/kernel-<version>/ was the wrong place to keep
> info about where to src for a given build is located.
> This information has to stay in the output directory.

Why can't there be two symlinks?

We have one now (the 'build' symlink) that points to the build machinery,
and adding another (the 'object' symlink) that points to object tree is no
big deal.

> So what I will implement is that during the kernel build process
> (not the install part) a symlink named 'source' is placed
> in the root of the output directory - and links to the root of
> the kernel src used for building the kernel.
> 
> Then /lib/modules/kernel-<version>/build/source will be where

Nobody gave me a veto right, but I yell VETO now!

> the source is located.
> And /lib/modules/kernel-<version>/build will point to the output files.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
