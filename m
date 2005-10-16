Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbVJPWPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbVJPWPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 18:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVJPWPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 18:15:30 -0400
Received: from mail.aei.ca ([206.123.6.14]:18663 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1750766AbVJPWPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 18:15:30 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: GIT 0.99.8d
Date: Sun, 16 Oct 2005 18:15:33 -0400
User-Agent: KMail/1.8.2
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <7vachadnmy.fsf@assigned-by-dhcp.cox.net> <7vll0txqwu.fsf@assigned-by-dhcp.cox.net> <20051016185540.GA27162@fiberbit.xs4all.nl>
In-Reply-To: <20051016185540.GA27162@fiberbit.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510161815.33833.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This explains things.  I am not building via the debian package.  What happened is that
sid (amd64) dropped libcurl3-dev and I did not add one of the other packages...

Thanks
Ed

On Sunday 16 October 2005 14:55, Marco Roeland wrote:
> On Sunday October 16th 2005 Junio C Hamano wrote:
> 
> > > Debian users beware.  This version introduces a dependency - package: 
> > > libcurl3-gnutls-dev
> > > is now needed to build git.
> > 
> > Is this really true?  The one I uploaded was built on this
> > machine:
> > 
> > : siamese; dpkg -l libcurl\* | sed -ne 's/^ii  //p'
> > libcurl3          7.14.0-2       Multi-protocol file transfer library, now wi
> > libcurl3-dev      7.14.0-2       Development files and documentation for libc
> > 
> > Having said that, a tested patch to debian/control to adjust
> > Build-Depends is much appreciated.
> 
> The present line is correct. In 'debian/control' the line reads
> (word-wrapped here):
> 
> Build-Depends-Indep: libz-dev, libssl-dev,
>  libcurl3-dev|libcurl3-gnutls-dev|libcurl3-openssl-dev, asciidoc (>=
>  6.0.3), xmlto, debhelper (>= 4.0.0), bc
> 
> So it works correct on 'stable' versions ('libcurl3-dev') and
> latest 'unstable' as well, where you have the choice of either
> 'libcurl3-gnutls-dev' or 'libcurl3-openssl-dev'.
