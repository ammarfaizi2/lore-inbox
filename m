Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVJPSzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVJPSzs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 14:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVJPSzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 14:55:48 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:20954 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751362AbVJPSzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 14:55:48 -0400
Date: Sun, 16 Oct 2005 20:55:40 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Junio C Hamano <junkio@cox.net>
Cc: Ed Tomlinson <tomlins@cam.org>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: GIT 0.99.8d
Message-ID: <20051016185540.GA27162@fiberbit.xs4all.nl>
References: <7vachadnmy.fsf@assigned-by-dhcp.cox.net> <200510161024.37873.tomlins@cam.org> <7vll0txqwu.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7vll0txqwu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 16th 2005 Junio C Hamano wrote:

> > Debian users beware.  This version introduces a dependency - package: 
> > libcurl3-gnutls-dev
> > is now needed to build git.
> 
> Is this really true?  The one I uploaded was built on this
> machine:
> 
> : siamese; dpkg -l libcurl\* | sed -ne 's/^ii  //p'
> libcurl3          7.14.0-2       Multi-protocol file transfer library, now wi
> libcurl3-dev      7.14.0-2       Development files and documentation for libc
> 
> Having said that, a tested patch to debian/control to adjust
> Build-Depends is much appreciated.

The present line is correct. In 'debian/control' the line reads
(word-wrapped here):

Build-Depends-Indep: libz-dev, libssl-dev,
 libcurl3-dev|libcurl3-gnutls-dev|libcurl3-openssl-dev, asciidoc (>=
 6.0.3), xmlto, debhelper (>= 4.0.0), bc

So it works correct on 'stable' versions ('libcurl3-dev') and
latest 'unstable' as well, where you have the choice of either
'libcurl3-gnutls-dev' or 'libcurl3-openssl-dev'.
-- 
Marco Roeland
